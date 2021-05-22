;by A. Percy -> Alexsandro Percy

#include <array.au3>

;~ $AdapterList = GetAdaptersList( )
;~ _ArrayDisplay( $AdapterList )
;~ MsgBox(0,"",$AdapterList[1][2])
;~ Exit

;------------------------------------------------------------------------------------------------------------
Func GetAdaptersList( $ListAll = 0 )
    Local $Cols = 5
    Local $Adapters[1][$Cols]
    $Adapters[0][0] = 0

    If @OSTYPE = "WIN32_NT" Then
        ;Use WMI
        Local $o_WMIService = ObjGet( "winmgmts:\\" & @ComputerName & "\root\cimv2" )
        Local $Query = "SELECT Index, Caption, MACAddress, IPAddress, DefaultIPGateway FROM Win32_NetworkAdapterConfiguration"
        If $ListAll = 0 Then
            $Query &= " Where IPEnabled = True"
        EndIf
        Local $o_Adapters = $o_WMIService.ExecQuery( $Query, "WQL", 0x30 )
        If IsObj( $o_Adapters ) Then
            Local $o_Adapter
            For $o_Adapter In $o_Adapters
                $Adapters[0][0] += 1
                ReDim $Adapters[UBound($Adapters) + 1][$Cols]
                $Adapters[$Adapters[0][0]][0] = $o_Adapter.Index                        ;index
                $Adapters[$Adapters[0][0]][1] = $o_Adapter.Caption                      ;adapter name
                $Adapters[$Adapters[0][0]][2] = $o_Adapter.MACAddress                   ;adapter real mac address
                $Adapters[$Adapters[0][0]][3] = $o_Adapter.IPAddress(0)                 ;IP
                $Adapters[$Adapters[0][0]][4] = $o_Adapter.DefaultIPGateway(0)          ;Default Gateway
            Next
        EndIf
    EndIf
    return $Adapters
EndFunc

;------------------------------------------------------------------------------------------------------------
#cs
from Microsoft Developer Network:

class Win32_NetworkAdapterConfiguration : CIM_Setting
{
  boolean ArpAlwaysSourceRoute;
  boolean ArpUseEtherSNAP;
  string Caption;
  string DatabasePath;
  boolean DeadGWDetectEnabled;
  string DefaultIPGateway[];
  uint8 DefaultTOS;
  uint8 DefaultTTL;
  string Description;
  boolean DHCPEnabled;
  datetime DHCPLeaseExpires;
  datetime DHCPLeaseObtained;
  string DHCPServer;
  string DNSDomain;
  string DNSDomainSuffixSearchOrder[];
  boolean DNSEnabledForWINSResolution;
  string DNSHostName;
  string DNSServerSearchOrder[];
  boolean DomainDNSRegistrationEnabled;
  uint32 ForwardBufferMemory;
  boolean FullDNSRegistrationEnabled;
  uint16 GatewayCostMetric[];
  uint8 IGMPLevel;
  uint32 Index;
  uint32 InterfaceIndex;
  string IPAddress[];
  uint32 IPConnectionMetric;
  boolean IPEnabled;
  boolean IPFilterSecurityEnabled;
  boolean IPPortSecurityEnabled;
  string IPSecPermitIPProtocols[];
  string IPSecPermitTCPPorts[];
  string IPSecPermitUDPPorts[];
  string IPSubnet[];
  boolean IPUseZeroBroadcast;
  string IPXAddress;
  boolean IPXEnabled;
  uint32 IPXFrameType[];
  uint32 IPXMediaType;
  string IPXNetworkNumber[];
  string IPXVirtualNetNumber;
  uint32 KeepAliveInterval;
  uint32 KeepAliveTime;
  string MACAddress;
  uint32 MTU;
  uint32 NumForwardPackets;
  boolean PMTUBHDetectEnabled;
  boolean PMTUDiscoveryEnabled;
  string ServiceName;
  string SettingID;
  uint32 TcpipNetbiosOptions;
  uint32 TcpMaxConnectRetransmissions;
  uint32 TcpMaxDataRetransmissions;
  uint32 TcpNumConnections;
  boolean TcpUseRFC1122UrgentPointer;
  uint16 TcpWindowSize;
  boolean WINSEnableLMHostsLookup;
  string WINSHostLookupFile;
  string WINSPrimaryServer;
  string WINSScopeID;
  string WINSSecondaryServer;
};
#ce