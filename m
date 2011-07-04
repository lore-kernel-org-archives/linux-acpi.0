From: Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Re: Need help debugging Sony Vaio VPCY2 backlight control problem
Date: Mon, 04 Jul 2011 10:46:47 +0200
Message-ID: <4E117DF7.2000602@fedoraproject.org>
References: <4E0E2155.4070508@fedoraproject.org> <4E0E4637.7000902@absence.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020508090609070600040909"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4E0E4637.7000902@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Mattia Dongili <malattia@linux.it>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508090609070600040909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Marco,

On 07/02/2011 12:12 AM, Marco Chiappero wrote:
> Il 01/07/2011 21:34, Michel Alexandre Salim ha scritto:
> Here there is something I don't understand, since the _BCM method stores
> the brightness level into an EC register (apparently which one depends
> whether the notebook is on battery or not, if BNCM is enabled), but no
> GFX related methods are then called. The fact that _BQC returns an
> updated value proves that it works, but looking at your DSDT I'd say
> that no change is indeed applied. Are you experiencing the same issue
> under Windows?
> 
Brightness control works perfectly under Windows, or I probably would
have returned the laptop for repairs :)

>> Kernel bug report here: https://bugzilla.kernel.org/show_bug.cgi?id=38342
>>
>> Fedora bug report: https://bugzilla.redhat.com/show_bug.cgi?id=689962
>>
>> Is the Vaio Y's backlight supposed to be controlled by sony-laptop
>> instead of by video.ko?
> 
> Not necessarily.
> 
>> Right now with sony-laptop, actual_brightness
>> always reads -1 no matter what value is written to brightness.
> 
In 3.0-rc5, sony-laptop.ko actually behaves like video.ko -- sysfs's
brightness file can be set, but actual_brightness does not budge.
Previously (as late as 2.6.38.8, and maybe 3.0-rc4 but I'm not 100% sure
about the latter), using sony-laptop.ko the brightness file also reads
-1 all the time, and Fn-F5/F6 shows it stuck to zero, whereas now it
concurs with the brightness file, pretending that brightness values are
changing.

Only diff now is that video.ko defaults to full brightness whereas
according to sony-laptop.ko, at boot up the brightness is 0. But that's
probably because video.ko's actual_brightness reads 8 (max) whereas
sony-laptop.ko reads actual_brightness of -1 (so defaulting brightness
to zero is sensible).
> In your laptop SBRT/GBRT methods use zero based values, so -1 is a
> reasonable value. But why are you always getting -1 (especially if the
> LCD brightness is maximized)? Maybe the if statement "If (^^EC0.BNEN)"
> is false, but why?
> 
>> If there's any information not currently attached to those bug reports
>> that is needed, please let me know.
> 
> Using the sony-laptop provided backlight device, try to dump the EC
> registers before and after changing the brightness value. You can use
> "ectool" or sysfs (depending on your kernel configuration).
> 
Here are the ectool dumps, before setting any brightness (backlight=0),
after setting it to 5, and after setting it to 3, plus the typescript
log of the commands issued and the sysfs readings.

I then set brightness back to 0 (ec-after3.txt) -- didn't log the
keyboard interactions because it's the same (value for brightness
concurs with what is set, but actual_brightness is still -1)

Let me know if you need anything else. Once we can at least pinpoint the
problem to the right subsystem, I'll add these attachments to the
correct bug report.

Thanks,

-- 
Michel Alexandre Salim

()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments

--------------020508090609070600040909
Content-Type: text/plain;
 name="ec-before.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ec-before.txt"

EC RAM:

00: 00 20 00 00 00 00 00 00 00 00 00 50 00 00 00 30 
10: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 f4 00 00 00 00 
50: c1 07 03 07 03 c4 00 00 00 01 00 00 07 00 00 00 
60: 80 80 00 00 00 00 00 0b d7 95 07 8f 65 55 39 f5 
70: 62 03 04 00 88 61 00 00 01 01 00 00 00 00 00 00 
80: 04 08 08 08 ff 00 00 ff 0b 00 00 06 00 00 00 00 
90: 00 00 00 04 9a 97 00 00 00 a1 00 00 00 00 03 0a 
a0: 82 80 80 80 80 80 80 80 2d 25 27 00 32 3b 12 00 
b0: 80 80 00 00 00 00 00 00 1a 00 00 00 00 00 00 00 
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
d0: 64 67 57 5a 00 00 00 7e 00 00 00 00 1d 00 00 00 
e0: 1a 14 a2 14 61 00 0c 01 9a 30 01 80 02 01 b2 0b 
f0: 30 57 2e 30 32 53 4e 2e 4b 30 2e 31 34 20 00 00 

Not dumping EC IDX RAM.

--------------020508090609070600040909
Content-Type: text/plain;
 name="ec-after.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ec-after.txt"

EC RAM:

00: 00 20 00 00 00 00 00 00 00 00 00 50 00 00 00 30 
10: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 f4 00 00 00 00 
50: c1 07 03 07 03 c4 00 00 00 01 00 00 07 00 00 00 
60: 80 80 00 00 00 00 00 0b d7 95 07 8f 65 55 39 f5 
70: 62 03 04 00 88 61 00 00 01 01 00 00 00 00 00 00 
80: 04 08 08 08 ff 00 00 ff 0b 00 00 06 00 00 00 00 
90: 00 00 00 04 9a 97 00 00 00 a1 00 00 00 00 03 0a 
a0: 82 80 80 80 80 80 80 80 2e 26 27 00 31 3b 12 00 
b0: 80 80 00 00 00 00 00 00 1a 00 00 00 00 00 00 00 
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
d0: 64 67 57 5a 00 00 00 7e 00 00 00 00 1d 00 00 00 
e0: 20 14 a2 14 62 00 fc 00 9c 30 01 80 f8 00 b4 0b 
f0: 30 57 2e 30 32 53 4e 2e 4b 30 2e 31 34 20 00 00 

Not dumping EC IDX RAM.

--------------020508090609070600040909
Content-Type: text/plain;
 name="ec-after2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ec-after2.txt"

EC RAM:

00: 00 20 00 00 00 00 00 00 00 00 00 50 00 00 00 30 
10: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 f4 00 00 00 00 
50: c1 07 03 07 03 c4 00 00 00 01 00 00 07 00 00 00 
60: 80 80 00 00 00 00 00 0b d7 95 07 8f 65 55 39 f5 
70: 62 03 04 00 88 61 00 00 01 01 00 00 00 00 00 00 
80: 04 08 08 08 ff 00 00 ff 0b 00 00 06 00 00 00 00 
90: 00 00 00 04 9a 97 00 00 00 a1 00 00 00 00 03 0a 
a0: 82 80 80 80 80 80 80 80 2e 26 28 00 31 3b 13 00 
b0: 80 80 00 00 00 00 00 00 1b 00 00 00 00 00 00 00 
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
d0: 64 67 57 5a 00 00 00 7e 00 00 00 00 1d 00 00 00 
e0: 2b 14 a2 14 62 00 d5 00 9c 30 01 80 d0 00 b8 0b 
f0: 30 57 2e 30 32 53 4e 2e 4b 30 2e 31 34 20 00 00 

Not dumping EC IDX RAM.

--------------020508090609070600040909
Content-Type: application/octet-stream;
 name="typescript"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="typescript"

U2NyaXB0IHN0YXJ0ZWQgb24gTW9uIDA0IEp1bCAyMDExIDEwOjMxOjI5IEFNIENFU1QKG10w
O3Jvb3RAc29qb3VybmVyOi9ob21lL21pY2hlbC9jaGVja291dHMvY29yZWJvb3QvdXRpbC9l
Y3Rvb2wHG1s/MTAzNGhbcm9vdEBzb2pvdXJuZXIgZWN0b29sXSMgLi9lY3Rvb2wgPiBlYy1i
ZWZvcmUudHh0IA0KG10wO3Jvb3RAc29qb3VybmVyOi9ob21lL21pY2hlbC9jaGVja291dHMv
Y29yZWJvb3QvdXRpbC9lY3Rvb2wHW3Jvb3RAc29qb3VybmVyIGVjdG9vbF0jIGNhdCAvZQgb
W0tzeXMvY2xhc3MvYmFja2xpZ2h0L3NvbnkvYWN0dWFsX2JyaWdodG5lc3MgDQotMQ0KG10w
O3Jvb3RAc29qb3VybmVyOi9ob21lL21pY2hlbC9jaGVja291dHMvY29yZWJvb3QvdXRpbC9l
Y3Rvb2wHW3Jvb3RAc29qb3VybmVyIGVjdG9vbF0jIGNhdCAvc3lzL2NsYXNzL2JhY2tsaWdo
dC9zb255L2FjdHVhbF9icmlnaHRuZXNzIAgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sI
G1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbS2JyaWdodG5lc3Mg
DQowDQobXTA7cm9vdEBzb2pvdXJuZXI6L2hvbWUvbWljaGVsL2NoZWNrb3V0cy9jb3JlYm9v
dC91dGlsL2VjdG9vbAdbcm9vdEBzb2pvdXJuZXIgZWN0b29sXSMgY2F0IC9zeXMvY2xhc3Mv
YmFja2xpZ2h0L3NvbnkvYnJpZ2h0bmVzcyAIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tL
CBtbSwgbW0sIG1tLCBtbSwgbW0svbWF4X2JyaWdodG5lc3MgDQo3DQobXTA7cm9vdEBzb2pv
dXJuZXI6L2hvbWUvbWljaGVsL2NoZWNrb3V0cy9jb3JlYm9vdC91dGlsL2VjdG9vbAdbcm9v
dEBzb2pvdXJuZXIgZWN0b29sXSMgZWNobyA1ID4gL3N5cy9jbGFzcy9iYWNrbGlnaHQvc29u
eS9tYXhfYnJpZ2h0bmVzcyAIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sI
G1tLCBtbSwgbW0sIG1tLCBtbSwgbW0tiYWNrbGlnaHQNCmJhc2g6IC9zeXMvY2xhc3MvYmFj
a2xpZ2h0L3NvbnkvYmFja2xpZ2h0OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQobXTA7
cm9vdEBzb2pvdXJuZXI6L2hvbWUvbWljaGVsL2NoZWNrb3V0cy9jb3JlYm9vdC91dGlsL2Vj
dG9vbAdbcm9vdEBzb2pvdXJuZXIgZWN0b29sXSMgZWNobyA1ID4gL3N5cy9jbGFzcy9iYWNr
bGlnaHQvc29ueS9iYWNrbGlnaHQIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbSwcN
CmJsX3Bvd2VyICAgIGJyaWdodG5lc3MgIA0KW3Jvb3RAc29qb3VybmVyIGVjdG9vbF0jIGVj
aG8gNSA+IC9zeXMvY2xhc3MvYmFja2xpZ2h0L3NvbnkvYnJpZ2h0bmVzcyANChtdMDtyb290
QHNvam91cm5lcjovaG9tZS9taWNoZWwvY2hlY2tvdXRzL2NvcmVib290L3V0aWwvZWN0b29s
B1tyb290QHNvam91cm5lciBlY3Rvb2xdIyANG1szUChyZXZlcnNlLWktc2VhcmNoKWAnOhtb
QwgICBtbNDdAZSc6IGVjaG8gNSA+IC9zeXMvY2xhc3MvYmFja2xpZ2h0L3NvbnkvYnJpZ2h0
bmVzcwgICA0bW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0Mb
W0MbW0MbW0MbW0MbW0MbWzFAYxtbQxtbQxtbQwgICBtbMjBQdCc6IC4vZWN0b29sID4gZWMt
YmVmb3JlLnR4dAgICAgICAgICAgICAgICAgICAgICAgICAgICBtbMUBvG1tDG1tDG1tDG1tD
G1tDDRtbMVBbcm9vdEBzb2pvdXJuZXIgZWN0b29sXSMbW0MbW0MbW0MbW0MbW0MbW0MbW0Mb
W0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0MbW0Mb
W0MICAgICAgbWzFQCBtbMVAIG1sxUAgbWzFQCBtbMVAIG1sxUBtbMUBhG1sxQGYbWzFAdBtb
MUBlG1sxQHINChtdMDtyb290QHNvam91cm5lcjovaG9tZS9taWNoZWwvY2hlY2tvdXRzL2Nv
cmVib290L3V0aWwvZWN0b29sB1tyb290QHNvam91cm5lciBlY3Rvb2xdIyBjYXQgL3N5cy9j
bGFzcy9iYWNrbGlnaHQvc29ueS9icmkIG1tLCBtbS2kIG1tLcmlnaHRuZXNzIA0KNQ0KG10w
O3Jvb3RAc29qb3VybmVyOi9ob21lL21pY2hlbC9jaGVja291dHMvY29yZWJvb3QvdXRpbC9l
Y3Rvb2wHW3Jvb3RAc29qb3VybmVyIGVjdG9vbF0jIGNhdCAvc3lzL2NsYXNzL2JhY2tsaWdo
dC9zb255L2JyaWdodG5lc3MgCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tL
CBtbSwgbW0thY3R1YWxfYnJpZ2h0bmVzcyANCi0xDQobXTA7cm9vdEBzb2pvdXJuZXI6L2hv
bWUvbWljaGVsL2NoZWNrb3V0cy9jb3JlYm9vdC91dGlsL2VjdG9vbAdbcm9vdEBzb2pvdXJu
ZXIgZWN0b29sXSMgZWNobyAzID4gL3N5cy9jbGFzcy9iYWNrbGlnaHQvc29ueS9icmlnaHRu
ZXNzIA0KG10wO3Jvb3RAc29qb3VybmVyOi9ob21lL21pY2hlbC9jaGVja291dHMvY29yZWJv
b3QvdXRpbC9lY3Rvb2wHW3Jvb3RAc29qb3VybmVyIGVjdG9vbF0jIA0bWzNQKHJldmVyc2Ut
aS1zZWFyY2gpYCc6G1tDCAgIG1s0N0BlJzogZWNobyAzID4gL3N5cy9jbGFzcy9iYWNrbGln
aHQvc29ueS9icmlnaHRuZXNzCAgIDRtbQxtbQxtbQxtbQxtbQxtbQxtbQxtbQxtbQxtbQxtb
QxtbQxtbQxtbQxtbQxtbQxtbQxtbQxtbQxtbQxtbMUBjG1tDG1tDG1tDCAgIG1syMVB0Jzog
Li9lY3Rvb2wgPiBlYy1hZnRlci50eHQICAgICAgICAgICAgICAgICAgICAgNW3Jvb3RAc29q
b3VybmVyIGVjdG9vbF0jG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tD
G1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDG1tDCAgICAgbWzFAMg0KG10wO3Jv
b3RAc29qb3VybmVyOi9ob21lL21pY2hlbC9jaGVja291dHMvY29yZWJvb3QvdXRpbC9lY3Rv
b2wHW3Jvb3RAc29qb3VybmVyIGVjdG9vbF0jIGNhdCAvc3lzL2NsYXNzL2JhY2tsaWdodC9z
b255L2FjCBtbSwgbW0ticmlnaHRuZXNzIA0KMw0KG10wO3Jvb3RAc29qb3VybmVyOi9ob21l
L21pY2hlbC9jaGVja291dHMvY29yZWJvb3QvdXRpbC9lY3Rvb2wHW3Jvb3RAc29qb3VybmVy
IGVjdG9vbF0jIGNhdCAvc3lzL2NsYXNzL2JhY2tsaWdodC9zb255L2JyaWdodG5lc3MgCBtb
SwgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0sIG1tLCBtbSwgbW0thY3R1YWxfYnJpZ2h0
bmVzcyANCi0xDQobXTA7cm9vdEBzb2pvdXJuZXI6L2hvbWUvbWljaGVsL2NoZWNrb3V0cy9j
b3JlYm9vdC91dGlsL2VjdG9vbAdbcm9vdEBzb2pvdXJuZXIgZWN0b29sXSMgZXhpdA0KClNj
cmlwdCBkb25lIG9uIE1vbiAwNCBKdWwgMjAxMSAxMDozNjowNCBBTSBDRVNUCg==
--------------020508090609070600040909--
