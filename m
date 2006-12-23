From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/22] acpi4asus sync with 0.31
Date: Fri, 22 Dec 2006 21:11:52 -0500
Message-ID: <200612222111.52411.lenb@kernel.org>
References: <200612192217.43660.corentincj@iksaif.net> <200612201749.32486.lenb@kernel.org> <20061221011705.GG29711@debian>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45040 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453AbWLWCNH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Dec 2006 21:13:07 -0500
In-Reply-To: <20061221011705.GG29711@debian>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julien Lerouge <julien.lerouge@m4x.org>
Cc: corentincj@iksaif.net, linux-acpi@vger.kernel.org, sziwan@users.sourceforge.net, acpi4asus-user@lists.sourceforge.net

On Wednesday 20 December 2006 20:17, Julien Lerouge wrote:
> ...Corentin is willing to maintain it. I don't know for
> Karol, but you can remove me from the MAINTAINERS.
> 
> Also, Corentin should be added to the list of the MAINTAINERS for this
> driver.

Thanks Julien, I'll update MAINTAINERS patch below.

Corentin, please ACK or NAK (note, I put your URL in there too)

I'll leave Karol's entry alone till I hear from him.

Corentin,
Do you agree that patches for asus_acpi should always appear on the
acpi4asus mailing list and get an ACK from you before being applied upstream?
(The only answer is yes:-)  I'll NAK them now:-)

But to apply your series, we need to first iron out a couple of logistics.

Per Documentation/SubmittingPatches

From: Original Author <author@example.com>
must appear on each patch to credit the original author.
Clarity on the Subject: line about what changed is important.
Important to keep cosmetic vs functional changes in different patches
and document such -- looks like you've done a good job of that --
though ideally the cosmetic patches come _after_ the functional ones
in case somebody wants to apply functional w/o cosmetic -- but not a hard rule.
Check-in comments go into the permanent record, so they don't
need to say thing like "this patch" etc, since that is implicit etc.

The series you sent is from you and signed-off-by you, which credits nobody else.
That is fine if you are the original author and only contributor, but needs to be updated if not.

Also, the e-mail patches must apply and not get garbled by your mailer due to line-wrap
per my previous message.

The patch series will ideally apply on top of any asus_acpi patches already in my tree.
But if not, then at a minimum they must apply to Linus' tree -- which is where you are now
and I can attempt to merge any conflicts.  If you'd rather merge the conflicts, then make
sure the series you send applied to my tree.

Re: development strategy
Asside from supporting your users, there are a couple of "big picture" things to be aware of.
It is clear that we need platform-specific drivers like asus_acpi, and always will.
However, to the extent that we create special API's to user-space in the form
of /proc or /sysfs files that appear only when that driver is loaded, we've failed.

We need to move towards common interfaces that make it simple for users and programmers
to talk to the kernel drivers, the backlight and led classes are good examples,
and input layer for keyboard events is another.  In these cases the user or
utility doesn't know or care about the model of laptop they have or the way
that the feature is implemented.  So while /proc/acpi/asus_acpi files were
practical for a prototype, they are what we want to move _away_ from,
and we should be working on deleting them and not changing what is there
and not adding any more /proc files.

Indeed, in the long term, all of /proc/acpi will be removed in favor of generic /sys
interfaces -- as ACPI itself is an implementation dependent way of making features
available to the user -- ie. not all systems have ACPI...

Some platform specific drivers use ACPI, some do not, but by definition,
they are platform specific and are not _part_ of ACPI (ie. not described in the spec).
Thus it doesn't make sense for them to live under /drivers/acpi in the source tree.
New platform specific drivers are being added to the tree under /drivers/misc/
for example, msi-laptop.c.  At some point, asus_acpi.c should move to /drivers/misc
if that is where they all end up.  However, I do not highly recommend re-naming the
actual driver, because users already know the module name asus_acpi.

In general, I'd like to see the platform specific drivers not implement features that
should be generic -- as the effort is better spent helping all users, not just those
with a specific model.  A good example of this is docking support emerging on ibm_acpi
and the dock driver at the same time -- I'd much rather see the effort go into the generic
driver when at all possible.  A good counter-example was they hotkey driver --
which failed to make it out of EXPERIMENTAL stage and will be removed
because there are more differences in the non-standard hotkey implementations
than there is common code that can be shared.

thanks,
-Len

diff --git a/MAINTAINERS b/MAINTAINERS
index d708702..68f72c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -404,13 +404,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 
 ASUS ACPI EXTRAS DRIVER
+P:	Corentin Chary
+M:	corentincj@iksaif.net
 P:	Karol Kozimor
 M:	sziwan@users.sourceforge.net
-P:	Julien Lerouge
-M:	julien.lerouge@free.fr
 L:	acpi4asus-user@lists.sourceforge.net
 W:	http://sourceforge.net/projects/acpi4asus
-W:	http://julien.lerouge.free.fr
+W:	http://xf.iksaif.net/acpi4asus
 S:	Maintained
 
 ATA OVER ETHERNET DRIVER
