From: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Fri, 23 Dec 2005 18:53:41 +0200
Message-ID: <43AC2B95.9060901@kroon.co.za>
References: <43A8F98D.3000704@csstirisano.co.za> <20051222110219.GB9838@elf.ucw.cz> <20051222120413.GA28743@suse.de> <43AAB13E.4080206@csstirisano.co.za> <20051222160633.GA3316@suse.de> <43AB9CD2.9090106@csstirisano.co.za> <20051223111239.GB10748@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060506090008040005090506"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051223111239.GB10748-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060506090008040005090506
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> 
>>>>With regards to the ACPI code though - I've managed to fix all the 
>>>>warnings and errors, except the one about the ResourceSource error, 
>>>>which according to the spec is optional but iasl insists it's required. 
>>>>No idea what I'm going to do about that.  Also not sure whether fixing 
>>>>_WAK to always return a value will actually do something.
>>>
>>>I do not remember that i would have to fix any DSDT bugs, everything worked
>>>with the original DSDT.
>>
>>There is only really one error that bothers me, and I read somewhere 
>>that the kernel doesn't look at it's value, and that is the _WAK call 
>>that doesn't return a value.  Unless that of course changed recently. 
>>And I can't recompile the DSDT due to those ResourceSource required 
>>errors, which seems to be a bug in iasl.
> 
> 
> Fix iasl, then ;-).

Will try when I get back from the movies.  I've seen one other message
that mentioned this same error in iasl, can't remember where though.

>>I still haven't managed to finish of the resume process.  The screen 
>>comes back up and console switching works but that is just about where 
>>it ends.  I don't see any kernel panic messages either.  Will RTFM and 
>>fool around some more.
> 
> RTFM will not help you here, I'm afraid. Try it with minimal kernel
> config.

Ok, that sucks.  This is what I get, one some VT that is not reachable
with Alt+Fx, I get this:

         inu
Back to C!
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 177

The inu is in yellow and I presume forms part of the word "Linux".  I
get this screen when it comes back, from here I can switch to all twelfe
VTs with Alt+Fx, and back to this screen with Alt+right from tty1.

On tty1 I can type, but that is the only VT.  This is also the VT I run
hibernate-ram from.  Auto-repeat however does not function.  The same
applies when running "echo mem > /sys/power/state"

When running hibernate it doesn't power down!  This seems odd since
powerdown works when going "init 0".  Anyhow, the last messages I see is
this:

Freezing processes
Preparing Image.
Starting to save the image..
Writing caches...
Doing atormic copy.
Writing kernel & process data...

And that is where it all stops.

That is all I've managed to become wizer today.  Really not particularly
usefull I know.  Sorry for the noise.

-- 
There are only 10 kinds of people in this world,
  those that understand binary and those that don't.
http://www.kroon.co.za/

--------------ms060506090008040005090506
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII5TCC
As0wggI2oAMCAQICAw3p1jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI4MjExMjIzWhcNMDYwMTI4MjExMjIz
WjBCMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZIhvcNAQkBFhBq
YWNvQGtyb29uLmNvLnphMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4CsLuOWD
wimwAv4QLdlT99frJCwzUBVQNL7c7x4ufEquAH6RamWfQyQHzykEJM8NeMIrfb+k3fZEi+ZU
g5sq2uIqzOuCJsIj0x3LnoydXTikbv1AFWQDEuqITlroA8bGJE/mMlbPrKyDACPo5cQAzUQz
LAg7LQQQVkKNWH4eeXUwZ5lOZEWWno0P5DXHdSLQxCshgWVPRrbtKe25WGObqJMa//1T5qX8
0mKIdAbHlz90BwgX/MjLp0BpXTii2653ScOujCLTC3cPdDUDK68qG7RqatVw5+HE/npJIWa1
0TxJUp5Ii8nPbGPzpEWQmZ8TjkjMs26w80PPPKh2Vh2siQIDAQABoy0wKzAbBgNVHREEFDAS
gRBqYWNvQGtyb29uLmNvLnphMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAqXNX
QEMTVQoj3JoEwK9vlfqSVz5ZEUklpgEhwFJsD+PKa/LgUGVHk3Gw8wws4+wZxmpOsJ7vdiWL
y8zlX7HfPWMcbibTi6C7nT6WahqdeAo3kVjhnMqJ3Sf6sX0JGl9bWfIhgmIVy/ZdM2ztrXwd
rbWiT7un5lM05D4YPCNH9fcwggLNMIICNqADAgECAgMN6dYwDQYJKoZIhvcNAQEEBQAwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1MDEyODIx
MTIyM1oXDTA2MDEyODIxMTIyM1owQjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJl
cjEfMB0GCSqGSIb3DQEJARYQamFjb0Brcm9vbi5jby56YTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAOArC7jlg8IpsAL+EC3ZU/fX6yQsM1AVUDS+3O8eLnxKrgB+kWpln0Mk
B88pBCTPDXjCK32/pN32RIvmVIObKtriKszrgibCI9Mdy56MnV04pG79QBVkAxLqiE5a6APG
xiRP5jJWz6ysgwAj6OXEAM1EMywIOy0EEFZCjVh+Hnl1MGeZTmRFlp6ND+Q1x3Ui0MQrIYFl
T0a27SntuVhjm6iTGv/9U+al/NJiiHQGx5c/dAcIF/zIy6dAaV04otuud0nDrowi0wt3D3Q1
AyuvKhu0amrVcOfhxP56SSFmtdE8SVKeSIvJz2xj86RFkJmfE45IzLNusPNDzzyodlYdrIkC
AwEAAaMtMCswGwYDVR0RBBQwEoEQamFjb0Brcm9vbi5jby56YTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBAUAA4GBAKlzV0BDE1UKI9yaBMCvb5X6klc+WRFJJaYBIcBSbA/jymvy4FBl
R5NxsPMMLOPsGcZqTrCe73Yli8vM5V+x3z1jHG4m04ugu50+lmoanXgKN5FY4ZzKid0n+rF9
CRpfW1nyIYJiFcv2XTNs7a18Ha21ok+7p+ZTNOQ+GDwjR/X3MIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCAzswggM3AgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAgMN6dYwCQYFKw4DAhoFAKCCAacwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUxMjIzMTY1MzQyWjAjBgkqhkiG9w0BCQQxFgQUFSGF
eoBJ9EFoo9WrgQYufH4kEBYwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYB
BAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0ECAw3p1jB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMN6dYwDQYJKoZIhvcNAQEBBQAEggEAwa6t2hw4PfjXJf4K
wE/8+7AQtnOkTdtPDY85/PxiNzbyBeYyZER+r+3fsq9ZZVLGsi//LmJZVPiLVyJ9lL1Tl5/g
FKPd8jTCPU45ZNWbrtGCyupbAQjH5s2DyA+2X/Utc79dRuABUT8wnIuwIXi0trN4Kfbh1/f3
GleICbvDbfe2HLwhjjOYYCCoKx+zKuyv4qIEtkwtZ3mkWLhzI1tGYRfyF1wVjjP/r5qVql1s
ItIfYDyDgvXE5LSeHey1KLk14jiF1yaYOlQIo67y0kRSKtjW4murQUYNNrffvV+Eg6QjKnFG
C96sYt3pF0uI2a47o4bI3moJrh3Dc0B+WpAoHAAAAAAAAA==
--------------ms060506090008040005090506--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
