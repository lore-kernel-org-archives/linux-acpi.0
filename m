From: Andrew Lutomirski <luto@mit.edu>
Subject: Ideapad S10-3 rfkill issues with fix
Date: Sat, 25 Jun 2011 16:53:17 -0600
Message-ID: <BANLkTi=HABawWJL2znCDRAM4MqEHPt9xEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec543083a44a6ba04a69130cf
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63647 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab1FYWxh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Jun 2011 18:53:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, ike.pan@canonical.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

--bcaec543083a44a6ba04a69130cf
Content-Type: text/plain; charset=ISO-8859-1

[linux-acpi cc'd because I don't know how to write to an ACPI field,
and the fix to this bug probably needs that ability.]

Hi platform people-

My nephew's Ideapad S10-3 decided that it didn't want to support
wireless anymore.  I think it happened when he fiddled with his rfkill
switch, but I haven't been able to reproduce the problem yet.  This
seems to be a common bug, and the only known fixes (so far) are to
boot into Windows and fiddle with the settings or to remove the CMOS
battery.

This seems to be related to:
http://ubuntuforums.org/showthread.php?t=1744402
https://bugs.meego.com/show_bug.cgi?id=4086
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/730972

Of course, he doesn't have Windows installed, and I didn't want to
take apart his laptop.  So I figured out the problem.

The relevant ACPI fields and functions are (as far as I can tell):

\FL07: The non-volatile copy of the RF enabled flag
\_SB.PCI0.LPCB.EC0.WRFS: RF enabled flag
\GO26: The GPIO line that controls the PHY (not really tested at all)
\GO28: The RF light, inverted.  This doesn't work without manual
override on my S10-3 because I don't have bluetooth or 3G, AFAICT.

\_SB.PCI0.LPCB.EC0.DSLD: Load WRFS from FL07 (on startup)
\_SB.PCI0.LPCB.EC0.DSSV: Save WRFS to FL07, called from some hotkey
handler or other
\_SB.PCI0.LPCB.EC0.DSGO: Commit WRFS to hardware (i.e. \GO26).

Oddly enough, nothing in the DSDT seems to write WRFS or FL07 except
to copy FL07 to WRFS.  So triggering the problem might involve
toggling the switch from inside BIOS or something similar.

The fix would be (I think) to change ideapad_sync_rfk_state to do this
(in pseudocode):
if (!hw_blocked != WRFS) {
  WRFS = !hw_blocked;
  DSSV()
  DSGO()
}

I don't plan to send a patch for two reasons:

1. I don't know how to write to an ACPI field.  acpi_ns_evaluate can
read fields, but it can't write them AFAICT.  The ability to write to
a field would be really nice.  I did it by frobbing the ports by hand.

2. My nephew's taking his laptop home tomorrow, so I won't be able to
test a patch.

In the mean time, if you are affected by this problem and you really
don't care how badly you damage your laptop, you could run the
attached program, passing 1 as a parameter.  Then you should probably
reboot.  Before you even consider trying that, you should check
whether the magic hardcoded numbers match your DSDT.  If you don't
know how to do that, then you probably shouldn't run the program.

--Andy

P.S.  Some people with this bug find that their system freezes hard
when they try and fail to fix it.  I think this is a bug in brcm80211
in 2.6.38 that's been fixed in brcmsmac in 2.6.39.  But I don't really
feel like testing that carefully, given that I've already fixed the
root cause.

--bcaec543083a44a6ba04a69130cf
Content-Type: text/x-python; charset=US-ASCII; name="set_wireless.py"
Content-Disposition: attachment; filename="set_wireless.py"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpd5tka11

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uCiMgQ29weXJpZ2h0IChjKSAyMDExIEFuZHkgTHV0b21pcnNr
aQojIExpY2Vuc2VkIHVuZGVyIHRoZSBHUEwgdjIKIwojIFRoaXMgcHJvZ3JhbSB3aWxsIHByb2Jh
Ymx5IGVhdCB5b3VyIHdpcmVsZXNzIGNhcmQsIHNldCB5b3VyIGxhcHRvcCBvbgojIGZpcmUsIGFu
ZCBvdGhlcndpc2UgY2F1c2UgZ3JlYXQgbWF5aGVtLiAgSWYgeW91IHJ1biBpdCBvbiBhbnl0aGlu
ZyBvdGhlcgojIHRoYW4gdGhlIG9uZSBwYXJ0aWN1bGFyIExlbm92byBJZGVhcGFkIFMxMC0zIEkg
dGVzdGVkIGl0IG9uLCBpdCBpcyBldmVuCiMgbW9yZSBsaWtlbHkgdG8gZGVzdHJveSB0aGluZ3Mu
ICBTbyBETyBOT1QgUlVOIFRISVMgUFJPR1JBTS4KIwojIEluIHRoZSBldmVudCB5b3UgZG8gcnVu
IHRoaXMgcHJvZ3JhbSwgeW91IG1pZ2h0IHdhbnQgdG8gZWl0aGVyIHJlYm9vdAojIG9yIGludm9r
ZSBcX1NCLlBDSTAuTFBDQi5FQzAuRFNHTygpIGFuZCBcX1NCLlBDSTAuTFBDQi5FQzAuRFNTVigp
CiMgYWZ0ZXJ3YXJkcy4KCmltcG9ydCBwb3J0aW8KaW1wb3J0IHN0cnVjdAppbXBvcnQgc3lzCmlt
cG9ydCBvcwoKcHJpbnQgJ0RvIG5vdCBydW4gdGhpcyBwcm9ncmFtLiAgSWYgeW91IHJlYWxseSB3
YW50IHRvIHJ1biBpdCwnCnByaW50ICd0eXBlICJJIGFtIGEgZm9vbCIuICBPdGhlcndpc2UgcHJl
c3MgQ3RybC1DLicKcHJpbnQgJ0lmIHlvdSB0eXBlICJJIGFtIGEgZm9vbCIgdGhlbiB5b3UgYWdy
ZWUgbm90IHRvIGhvbGQgdGhlIGF1dGhvciBvZicKcHJpbnQgJ3RoaXMgcHJvZ3JhbSByZXNwb25z
aWJsZSBmb3IgYW55dGhpbmcgdGhhdCBnb2VzIHdyb25nLicKCmlmIHJhd19pbnB1dCgpICE9ICJJ
IGFtIGEgZm9vbCI6CiAgICBzeXMuZXhpdCgxKQoKaWYgcG9ydGlvLmlvcGVybSgweDcyLCAweDIs
IDEpOgogICAgcHJpbnQgPj5zeXMuc3RkZXJyLCAnWW91IG11c3QgYmUgcm9vdCB0byB1c2UgdGhp
cy4nCiAgICBzeXMuZXhpdCgxKQoKb3Muc3lzdGVtKCdtb2Rwcm9iZSBlY19zeXMnKQoKZWNfaW8g
PSBvcy5vcGVuKCcvc3lzL2tlcm5lbC9kZWJ1Zy9lYy9lYzAvaW8nLCBvcy5PX1JEV1IpCgpkZWYg
cmVhZF9lYyhpZHgpOgogICAgb3MubHNlZWsoZWNfaW8sIGlkeCwgb3MuU0VFS19TRVQpCiAgICBy
ZXR1cm4gc3RydWN0LnVucGFjaygnQicsIG9zLnJlYWQoZWNfaW8sIDEpKVswXQoKZGVmIHdyaXRl
X2VjKGlkeCwgZGF0YSk6CiAgICBvcy5sc2VlayhlY19pbywgaWR4LCBvcy5TRUVLX1NFVCkKICAg
IG9zLndyaXRlKGVjX2lvLCBzdHJ1Y3QucGFjaygnQicsIGRhdGEpKQoKZGVmIHJlYWRfZXhjbyhp
ZHgpOgogICAgcG9ydGlvLm91dGIoaWR4LCAweDcyKQogICAgcmV0dXJuIHBvcnRpby5pbmIoMHg3
MykKCmRlZiB3cml0ZV9leGNvKGlkeCwgZGF0YSk6CiAgICBwb3J0aW8ub3V0YihpZHgsIDB4NzIp
CiAgICBwb3J0aW8ub3V0YihkYXRhLCAweDczKQoKRkwwN19JRFggPSAweEEwCkZMMDdfTUFTSyA9
IDB4ODAKCldSRlNfSURYID0gMHhCRgpXUkZTX01BU0sgPSAweDQKCkZMMDdfcmVnID0gcmVhZF9l
eGNvKEZMMDdfSURYKQpXUkZTX3JlZyA9IHJlYWRfZWMoV1JGU19JRFgpCgpwcmludCAnRkwwNyA9
ICVkICBXUkZTID0gJWQnICUgKChGTDA3X3JlZyAmIEZMMDdfTUFTSykgIT0gMCwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAoV1JGU19yZWcgJiBXUkZTX01BU0spICE9IDApCgppZiBs
ZW4oc3lzLmFyZ3YpID09IDE6CiAgICBwcmludCAnTm90aGluZyBjaGFuZ2VkJwplbGlmIGxlbihz
eXMuYXJndikgPT0gMjoKICAgIGlmIHN5cy5hcmd2WzFdID09ICcwJzoKICAgICAgICB2YWwgPSAw
CiAgICBlbGlmIHN5cy5hcmd2WzFdID09ICcxJzoKICAgICAgICB2YWwgPSAxCiAgICBlbHNlOgog
ICAgICAgIHByaW50ID4+c3lzLnN0ZGVyciwgJ1lvdSBjYW4gb25seSB3cml0ZSAwIG9yIDEnCgog
ICAgd3JpdGVfZWMoV1JGU19JRFgsIFdSRlNfcmVnICYgKH5XUkZTX01BU0spIHwgKHZhbCAqIFdS
RlNfTUFTSykpCiAgICB3cml0ZV9leGNvKEZMMDdfSURYLCBGTDA3X3JlZyAmICh+RkwwN19NQVNL
KSB8ICh2YWwgKiBGTDA3X01BU0spKQoKICAgIHByaW50ICdEb25lLicKZWxzZToKICAgIHByaW50
ID4+c3lzLnN0ZGVyciwgJ1RvbyBtYW55IGFyZ3VtZW50cycKICAgIHN5cy5leGl0KDEpCgpzeXMu
ZXhpdCgwKQo=
--bcaec543083a44a6ba04a69130cf--
