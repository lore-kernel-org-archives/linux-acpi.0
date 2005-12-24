From: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Sat, 24 Dec 2005 10:45:58 +0200
Message-ID: <43AD0AC6.9060904@kroon.co.za>
References: <20051222160633.GA3316@suse.de> <43AB9CD2.9090106@csstirisano.co.za> <20051223111239.GB10748@elf.ucw.cz> <43AC2B95.9060901@kroon.co.za> <20051223172459.GB15357@elf.ucw.cz> <43AC80F3.6040605@kroon.co.za> <20051223230133.GC16104@elf.ucw.cz> <43AC9127.10007@kroon.co.za> <20051224002527.GA16285@elf.ucw.cz> <43AC97E7.1030800@kroon.co.za> <20051224003808.GB16285@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040701080807010002010907"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051224003808.GB16285-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

--------------ms040701080807010002010907
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Hi!
> 
> 
>>>Okay, what *other* patches do you have installed? What kernel are you
>>>running? 2.6.15-rc6?
>>
>>I'm trying with 2.6.14.3, but I've got 2.6.15rc5 available here (can
>>always get the VI patch to rc6).  Was intending to run the acpi_include
>>patch, but since that is a standard option in 2.6.14.x I never actually
>>pulled in that patch, so no other patches and I've backed out suspend2
>>now.  Will also give 15rc6 a go in the morning.
> 
> rc5 should be good enough.

Same problem.  SysRq+T reveals that the newly spawned process is getting
stuck in:

ide_do_request+0x18a/0x3c5
io_schedule+0xe/0x16
sync_page+0x3e/0x4b
__wait_on_bit_lock+0x41/0x61
sync_page+0x0/0x4b
__lock_page+0x9d/0xb1
wake_bit_function+0x0/0x55
wake_bit_function+0x0/0x55
do_generic_mapping_read+0x335/0x7fd
__generic_file_aio_read+0x19d/0x203
file_read_actor+0x0/0xfa
generic_file_read+0xba/0xd8
autoremove_wake_function+0x0/0x57
vfs_read+0x1a5/0x1aa
kernel_read+0x50/0x5f
prepare_binprm+0xd8/0x103
do_execve+0xfe/0x203
sys_execve+0x3c/0x6f
sysenter_past_esp+0x54/0x75

Second run round the first command I issued worked fine, as did cd to
/usr/src/linux, but running make menuconfig failed.  This time the stack
trace was considerably longer (I'm not going to type that over).  The
top two calls are the same, but it comes in from sync_buffer,
__wait_on_bit, sync_buffer, sync_buffer, out_of_line_wait_on_bit,
wake_bit_function, wakebit_function, and so forth.  A quick scan of the
VI between rc5  and rc6 doesn't reveal any changes that could possibly
affect this (I'm going to patch to rc6 in any case).

Could it be a bug in reiserfs?  I have run a fsck but no errors were
found, so I presume the fs is still in tact.

Right, I've done this for userspace programs linked with -rdynamic
before, but how do I convert those hexadecimal offsets into line numbers
for the kernel?  Just point me at the docs to RTFM so that I can RTFS.

The keyboard auto-repeat still breaks.  If it's possible to re-enable
this using some command-line tool (which I'm not aware off) then I can
just re-enable that manually from a suspend/resume script.

>>>>This feels like a post-wakeup racecondition to me... Disabling the big
>>>>kernel lock preemption think again... yes, seems to be working better
>>>>now.  Suspending to ram and then to disk still fails.  (resume from mem
>>>>works, can do make menuconfig - a few times - and then it starts
>>>>suspend-to-disk process and then just hangs).
>>>
>>>So... there's no module to blame? I do have CONFIG_PREEMPT=y and
>>>CONFIG_PREEMPT_BKL=y set here, but there were some problems with those
>>>before, so keeping it disabled may be wise.
>>
>>I've also found that I forgot to disable registers.  Neither made a
>>difference though.
> 
> CONFIG_REGPARM?

Argh.  It was too early in the morning (late at night?).  Yes.

>>>Ouch and now that suspend-to-ram more or less works for you, can you
>>>submit update to Doc*/power/video.txt?
>>
>>Will do if I get it working.  more-or-less is simply not good enough (or
>>should I just make a note there?).
> 
> It is good enough for video.txt. It describes how to get _video_
> working, and video works just ok for you.

You should have received the patch.

Jaco
-- 
There are only 10 kinds of people in this world,
  those that understand binary and those that don't.
http://www.kroon.co.za/

--------------ms040701080807010002010907
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUxMjI0MDg0NTU4WjAjBgkqhkiG9w0BCQQxFgQUbyXi
xwEe1t1/EEMdRK0ThkoYn6YwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYB
BAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0ECAw3p1jB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMN6dYwDQYJKoZIhvcNAQEBBQAEggEAeeyGcm9zML05HCK1
/MAYg2rCW+LLJxrsQYAs2QyfQHR9/A+icKaVs0IHic0F0//SH4SNHckRxwnyNhVntn6IsrkX
oUuEus8AMSdcLLHldb1hXTijZLB0OTK15NHoe4tgpl9de24ayn73E4uOFrOzRN0x8Ic+gzvo
Jc1tBvntAZLr0v27XMbIi+VCVGkBQZtYPq/ts3589eJ+b3pPQalDCtV+ZaOZJS2HauJ18Hxf
DEnVv42j3eHBVOEwEuUzC4tuPlV7VvBYZdv548ZfBqKCr0kjRMDc9HKxTeuGmBFJqqBNddMr
bDQ1Q6gSblbBrvbVFnYTfZFBJbRGOQyARFu2cAAAAAAAAA==
--------------ms040701080807010002010907--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
