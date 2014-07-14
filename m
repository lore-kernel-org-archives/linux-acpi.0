From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Mon, 14 Jul 2014 14:59:44 +0200
Message-ID: <87pph8kse7.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:47488 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192AbaGNNBE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 09:01:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Yes, I actually bisected this just to get

886129a8eebebec260165741fe31421482371006 is the first bad commit
commit 886129a8eebebec260165741fe31421482371006
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Tue May 6 14:46:23 2014 +0200

    ACPI / video: change acpi-video brightness_switch_enabled default t=
o 0
   =20
    acpi-video is unique in that it not only generates brightness up/do=
wn
    keypresses, but also (sometimes) actively changes the brightness it=
self.
   =20
    This presents an inconsistent kernel interface to userspace, basica=
lly there
    are 2 different scenarios, depending on the laptop model:
   =20
     1) On some laptops a brightness up/down keypress means: show a bri=
ghtness osd
     with the current brightness, iow it is a brightness has changed no=
tification.
   =20
     2) Where as on (a lot of) other laptops it means a brightness up/d=
own key was
     pressed, deal with it.
   =20
    Most of the desktop environments interpret any press as in scenario=
 2, and
    change the brightness up / down as a response to the key events, ca=
using it
    to be changed twice, once by acpi-video and once by the DE.
   =20
    With the new default for video.use_native_backlight we will be movi=
ng even
    more laptops over to behaving as in scenario 2. Making the remainin=
g laptops
    even more of a weird exception. Also note that it is hard to detect=
 scenario
    1 properly in userspace, and AFAIK none of the DE-s deals with it.
   =20
    Therefor this commit changes the default of brightness_switch_enabl=
ed to 0
    making its behavior consistent with all the other backlight drivers=
=2E
   =20
    Signed-off-by: Hans de Goede <hdegoede@redhat.com>
    Reviewed-by: Aaron Lu <aaron.lu@intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 5bbac8c4f3e9fd5421daf84289004c32c3217f2a 82c99a358bda636=
0f845b6063182d3e707ff90f0 M      Documentation
:040000 040000 81ed56a41130bbbea980620114ff11e3bb23ee63 a9870ba1d046bde=
69796060304c78dfbb1d00a1f M      drivers



The fact that this seems to be an *intentional* breakage does not help =
a
lot.  Yes, I understand that you believe the choice of default was
incorrect for some reason.  You might even be right about that.  But
that is still not a valid reason to break existing configurations for
end users!  Please do not do that.

Note that NO USER cares about "some laptops" or "other laptops".  They
care about their own systems, which either
 a) depend on the old default and therefore breaks with your change, or
 b) have a user modified setting and therefore are unaffected by your
    change

The above commit should be reverted.  It causes breakage for end users.

If you think the default was wrong, then please go back in time and fix
it when it was introduced. Thanks.


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
