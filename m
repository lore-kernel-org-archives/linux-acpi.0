From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Tue, 20 Sep 2005 23:06:17 +0200
Message-ID: <20050920210617.GA1779@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com> <m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com> <Pine.SOC.4.61.0509111140550.9218@math.ut.ee> <m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com> <m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965121AbVITVJT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com, Pierre Ossman <drzeus-list@drzeus.cx>, acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com, Masoud Sharbiani <masouds@masoud.ir>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> In the lead up to 2.6.13 I fixed a large number of reboot
> problems by making the calling conventions consistent.  Despite
> checking and double checking my work it appears I missed an
> obvious one.
> 
> The S4 suspend code for PM_DISK_PLATFORM was also calling
> device_shutdown without setting system_state, and was
> not calling the appropriate reboot_notifier.

ACK on both. But should not you submit patch via -mm, so it gets at
least some testing there?
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
