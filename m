From: Oliver Henriot <Oliver.Henriot@imag.fr>
Subject: Re: understanding acpi
Date: Mon, 04 Dec 2006 15:21:01 +0100
Message-ID: <45742ECD.6090203@imag.fr>
References: <456EB894.20306@imag.fr> <45741364.5040308@tlen.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050600060705070107090509"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imag.imag.fr ([129.88.30.1]:49095 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S936892AbWLDOVP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2006 09:21:15 -0500
In-Reply-To: <45741364.5040308@tlen.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rodney Cacy <cacy-rodney-cacy@tlen.pl>
Cc: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050600060705070107090509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Rodney Cacy a écrit :
> I'm not an expert but you can pass a boot kernel option:
>
> processor.max_cstate
Yes, I'd actually tried setting processor.max_cstate=4 a while ago to 
see if this changed anything and indeed, instead of reading
max_cstate : C8
from /proc/acpi/processor/CPU0/power as I usually get, I got
max_cstate : C4
Obivious, and no good either, unfortunately. I still ran at C2 on mains 
and C3 on battery.
I suspect my settings in /etc/acpi are not good and I'm looking for a 
fine manual I could rtfm in order to understand what I should doo to 
fine tune acpi on my machine. Where I'm stuck is to find the fine manual 
which I'll actually understand (I may not be very smart... ;-) ) and 
manage to put into application.
> More inforamtion in 
> http://www.columbia.edu/~ariel/acpi/acpi_howto.txt, section 7.
Yes, I'm actually trying to understand sections 6.3 through 6.6 of that 
same document, which I suspect are precisely what I'm looking for and 
also point at /etc/acpi. My relatively limited skills are preventing me 
from getting any further at the moment, but I am confident I will 
eventually make something of it.
> Write me about the results. Now I'm working under suspending sound,lan 
> etc. to save battery but soon I will work with the noise reduction.
>
> Cacy

Cheers,

P.S. considering the level of other discussions on this list, I suspect 
I have pointed my questions to the wrong place. Question : is there a 
noob oriented discussion list for acpi? Anyway, sorry for the list 
pollution with such "low level" questions.
>
>
> Oliver Henriot wrote:
>> Hi all list subscribers,
>>
>> I'm looking for info on how acpi functions in order to get it to work 
>> the best possible on my computer. It's a Sony laptop (vaio 
>> vgn-sz3xp/c, core2duo) running Debian Etch. In particular, I'm 
>> looking for ways to reduce thermal dissipation from the CPU as much 
>> as possible, in order to queep the machine as quiet as possible. From 
>> the various docs I've read, so far I seem to understand that C-states 
>> is the way to go, throttling being probably not very efficient.
>>
>> When I'm running on batteries, C3 state is active (as shown by cat 
>> /prc/acpi/processor/CPU0/power) and is the main state, whereas when 
>> I'm running on mains, C3 disappears and only C1 and C2 remain.
>>
>> My question are : wouldn't it be better if I could use C3 even when 
>> on mains. Wouldn't it be even better with C4? As suggested by "Why My 
>> Cx Power State Is Not Used" I tried unloading various modules (e.g. 
>> those concerning usb but I got stuck with usbcore which refused to 
>> unload despite nothing usb being connected) without any success. 
>> Being relatively new to GNU/Linux, I'm a bit stuck here and don't 
>> know where to look or what to make of this.
>>
>> Any help would be gladly welcome.
>>
>> Cheers,
>>
>> Oliver
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--------------ms050600060705070107090509
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMzzCC
A20wggJVoAMCAQICAQIwDQYJKoZIhvcNAQEEBQAwKzELMAkGA1UEBhMCRlIxDTALBgNVBAoT
BENOUlMxDTALBgNVBAMTBENOUlMwHhcNMDEwNDI3MDU0NjQ5WhcNMTEwNDI1MDU0NjQ5WjA0
MQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFuZGFyZDCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANzhHiE9BovqvV60iNsPk5e0bQc9hmIA
Lcr/tUqO51akj2Es8aAqq/Yq3Xwsv+91VQusCU7nTmHA5wzwkBVFEgLCjOvDEmTiYxAYLssH
MdmB5dwpgpsxVuKBHopvp+ipWBFEVoNds054cC3ftv1ygUXV8e5Nzu++1T0MkCBFmgmArw9M
2iAOgL86s+sngMC5D8ChTkDcOv1qKr9A1SxxgPn4umvk6ioAqy++mvCndm2YKZwPL/BC8hiX
W8n2zBlfusK+EtJcsJCUwLfLBgTvjzDtMi16SveTu6AJpLTuM8vQg5u1tbOQ3o6QHlmcINVL
Hu3XTE+G+hw6KqHprAWgnb8CAwEAAaOBkjCBjzAMBgNVHRMEBTADAQH/MB0GA1UdDgQWBBRn
WaXlB3RJA+8Fz8wupBjVEMiePDBTBgNVHSMETDBKgBRW62i50lx+mLWlU8ORb2NYxPlrt6Ev
pC0wKzELMAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxDTALBgNVBAMTBENOUlOCAQAwCwYD
VR0PBAQDAgEGMA0GCSqGSIb3DQEBBAUAA4IBAQAGA0eDckWQwk7hIderF6kBVQbKQG1Voh1e
6+IUI1nkCeKQ9jyNNgYPS6cmI2XC6gaacru4jMuKX+95NiV+ANfzBpT7g0QpJjfH7umHzmyG
gBtxPdJir/bNYmxTD+Z6kwCMey4z4EEdqr5lmHbxlQd0s+Y/U3XVSwY2SynE9tyOE4BAEHOC
rRV7BHFQtTcz8shku6EQfjbGra9vcFKm0a7MzLqw6FkSj2INrQPdSyroiTmIUS/tYei3MIfb
J1VtZoejUQmAYXFRBb4THdlBMPx1XwqWmxj/vpCBtBPAchEI/Wqaage99IMstGA2ZAf6PWqn
sJAEdoPdM8s04heYBAuhMIIEqzCCA5OgAwIBAgICPqowDQYJKoZIhvcNAQEEBQAwNDELMAkG
A1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNVBAMTDUNOUlMtU3RhbmRhcmQwHhcNMDYw
OTA0MTE0MDQyWhcNMDcwOTA0MTE0MDQyWjBrMQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05S
UzENMAsGA1UECxMERlI3MTEXMBUGA1UEAxMOT2xpdmVyIEhlbnJpb3QxJTAjBgkqhkiG9w0B
CQEWFk9saXZlci5IZW5yaW90QGltYWcuZnIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQCyNl4NNKoxifg7S153OeCW5a54sL+5LiDJnYJxkpJAXIkvg3dCCFEah7Ui47aIhWwI
lixnwZQKrm2rf6bz7hR1XF6snAMXJdqN6tDA+j3Spno/Ap77wZjJvYV4m9vM0JTF5rzcO0am
Mb0XP2rSw89bbI7+IXNl90/toJT+BkplGsxJi561C0HgbCxvmLG+q75UW78pv+d41lQbs96M
bjHUQGyDkzt1AtU3OW1YiHr33BIyNXSYSfHGgfz3ZOjb496bfCTftLs9xro5HkpYI5PNOa1x
Or6R9uOydv+KX010kjTb5H+WZCGo2mzHaO4i7taKbCUKt7V09d2zX8XQH+NbAgMBAAGjggGO
MIIBijAMBgNVHRMBAf8EAjAAMBEGCWCGSAGG+EIBAQQEAwIEsDAOBgNVHQ8BAf8EBAMCBeAw
eAYJYIZIAYb4QgENBGsWaUNlcnRpZmljYXQgQ05SUy1TdGFuZGFyZC4gUG91ciB0b3V0ZSBp
bmZvcm1hdGlvbiBzZSByZXBvcnRlciDgIGh0dHA6Ly9pZ2Muc2VydmljZXMuY25ycy5mci9D
TlJTLVN0YW5kYXJkLzAdBgNVHQ4EFgQU6H78Ol0mMubat4BoYbZ/Rw/j/l0wUwYDVR0jBEww
SoAUZ1ml5Qd0SQPvBc/MLqQY1RDInjyhL6QtMCsxCzAJBgNVBAYTAkZSMQ0wCwYDVQQKEwRD
TlJTMQ0wCwYDVQQDEwRDTlJTggECMCEGA1UdEQQaMBiBFk9saXZlci5IZW5yaW90QGltYWcu
ZnIwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybHMuc2VydmljZXMuY25ycy5mci9DTlJT
LVN0YW5kYXJkL2dldGRlci5jcmwwDQYJKoZIhvcNAQEEBQADggEBAB8tLxj4B1fWbQDswyyR
FtHYSkomAFb5ajZVvlRQL9AGGzWvLj7Skn286EOStNGtekmJJ+tZsFlWgNeV3b06XmPa4D8X
znTTlQjSl5eMHJ7n07xips8br+uhUZRlAGN49fKV4aSTY3D+/2u45X6lFLZP7bM1MmtqXgcD
u6XWZQupvOUfa9w8+hozfsIWlzhIcfXmFXa7+R7kXjk/39RDk0/9pN8v5Xp67PBSKp44CR1D
HwBfEoFLHkErr/3yjIK42uiiTerxmfnARGQB2VXHd6ENf+TbtZRoTNcADndi/WbW3TaCWO9D
AQJtxj0k7xJwN/+WkRalbUu+GoF9+ZKyVFIwggSrMIIDk6ADAgECAgI+qjANBgkqhkiG9w0B
AQQFADA0MQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFu
ZGFyZDAeFw0wNjA5MDQxMTQwNDJaFw0wNzA5MDQxMTQwNDJaMGsxCzAJBgNVBAYTAkZSMQ0w
CwYDVQQKEwRDTlJTMQ0wCwYDVQQLEwRGUjcxMRcwFQYDVQQDEw5PbGl2ZXIgSGVucmlvdDEl
MCMGCSqGSIb3DQEJARYWT2xpdmVyLkhlbnJpb3RAaW1hZy5mcjCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBALI2Xg00qjGJ+DtLXnc54Jblrniwv7kuIMmdgnGSkkBciS+Dd0II
URqHtSLjtoiFbAiWLGfBlAqubat/pvPuFHVcXqycAxcl2o3q0MD6PdKmej8CnvvBmMm9hXib
28zQlMXmvNw7RqYxvRc/atLDz1tsjv4hc2X3T+2glP4GSmUazEmLnrULQeBsLG+Ysb6rvlRb
vym/53jWVBuz3oxuMdRAbIOTO3UC1Tc5bViIevfcEjI1dJhJ8caB/Pdk6Nvj3pt8JN+0uz3G
ujkeSlgjk805rXE6vpH247J2/4pfTXSSNNvkf5ZkIajabMdo7iLu1opsJQq3tXT13bNfxdAf
41sCAwEAAaOCAY4wggGKMAwGA1UdEwEB/wQCMAAwEQYJYIZIAYb4QgEBBAQDAgSwMA4GA1Ud
DwEB/wQEAwIF4DB4BglghkgBhvhCAQ0EaxZpQ2VydGlmaWNhdCBDTlJTLVN0YW5kYXJkLiBQ
b3VyIHRvdXRlIGluZm9ybWF0aW9uIHNlIHJlcG9ydGVyIOAgaHR0cDovL2lnYy5zZXJ2aWNl
cy5jbnJzLmZyL0NOUlMtU3RhbmRhcmQvMB0GA1UdDgQWBBTofvw6XSYy5tq3gGhhtn9HD+P+
XTBTBgNVHSMETDBKgBRnWaXlB3RJA+8Fz8wupBjVEMiePKEvpC0wKzELMAkGA1UEBhMCRlIx
DTALBgNVBAoTBENOUlMxDTALBgNVBAMTBENOUlOCAQIwIQYDVR0RBBowGIEWT2xpdmVyLkhl
bnJpb3RAaW1hZy5mcjBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3Jscy5zZXJ2aWNlcy5j
bnJzLmZyL0NOUlMtU3RhbmRhcmQvZ2V0ZGVyLmNybDANBgkqhkiG9w0BAQQFAAOCAQEAHy0v
GPgHV9ZtAOzDLJEW0dhKSiYAVvlqNlW+VFAv0AYbNa8uPtKSfbzoQ5K00a16SYkn61mwWVaA
15XdvTpeY9rgPxfOdNOVCNKXl4wcnufTvGKmzxuv66FRlGUAY3j18pXhpJNjcP7/a7jlfqUU
tk/tszUya2peBwO7pdZlC6m85R9r3Dz6GjN+whaXOEhx9eYVdrv5HuReOT/f1EOTT/2k3y/l
enrs8FIqnjgJHUMfAF8SgUseQSuv/fKMgrja6KJN6vGZ+cBEZAHZVcd3oQ1/5Nu1lGhM1wAO
d2L9ZtbdNoJY70MBAm3GPSTvEnA3/5aRFqVtS74agX35krJUUjGCAq4wggKqAgEBMDowNDEL
MAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNVBAMTDUNOUlMtU3RhbmRhcmQCAj6q
MAkGBSsOAwIaBQCgggFJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTA2MTIwNDE0MjEwMVowIwYJKoZIhvcNAQkEMRYEFMCH+fDi2TLfmtwr7+FQfuNEehnU
MEkGCSsGAQQBgjcQBDE8MDowNDELMAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNV
BAMTDUNOUlMtU3RhbmRhcmQCAj6qMEsGCyqGSIb3DQEJEAILMTygOjA0MQswCQYDVQQGEwJG
UjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFuZGFyZAICPqowUgYJKoZIhvcN
AQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEATIt1GTUVZf4rC84YX5u9
idRiSeVR8BJXgucK9e/+PmodIEQP36eUMLrbN8HIuByr2TvfusF3URE6Ui4Au/N4LsqY8KDB
RzPCswafaL3SqBE01vXYZUvLvmnoDmTz5Waty2IeiRmb7Nnqu2+AwXBk6a6RqQLKyHvhm39N
1UaVS2MAWgNUM+/KAO1Z96VOBvOdU6BSrAeU5sHOPBGGrwH6x1JD0VtZwkm2GpyI3MJtbJ7r
iqXnkYzVclZ015dByyfTWgtYuiCTP5IrFmSK2o5KQRUMhPsNstY4s9lAiYWOpB+u8j3RlRTL
x9EWH/wiQELp+KobIuEk2Su9hUBGIc7V9AAAAAAAAA==
--------------ms050600060705070107090509--
