From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: RE: Patch for ospmd thermal gui
Date: Mon, 31 Mar 2003 23:39:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049146793.528.29.camel@localhost>
References: <F760B14C9561B941B89469F59BA3A84725A23D@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <F760B14C9561B941B89469F59BA3A84725A23D-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mon, 2003-03-31 um 20.36 schrieb Grover, Andrew:
> Thanks!

I should have mentioned that this patch is incremental to the other one
I sent to you, which added autotools support...

> (BTW we are going to switch from the ACPI CA license to the BSD license,
> is that OK with you?)

No problem. 

> Yes. I'm assuming the user will be using a GUI-specific PM control panel
> program, so my thought was that all these would act on the same power
> policy by using libpower to talk to ospmd. This makes the interface
> libpower exposes VERY IMPORTANT. 

Would you have the time to draw up an API for libpower (which maybe
should be named libospmd?!)? This could prevent some misunderstandings -
and I would happily start implementing it....

> Well, cooling mode is only supposed to be specified by the user, so I
> don't think ospmd would change it by itself. 

Hmmm..AFAIU ospmd is supposed to take care of user-specified power
policies, which are set through libpower: so I would think the user
should rather not be able to directly activate active cooling but it
should be done by ospmd in two cases: the user specified active cooling
when temperature reaches a certain point - or some (default) value is
reached which is assumed critical for passive cooling. 

> However, there is a lot of
> room for ospmd to take the user's preference and then do the right thing
> based on that. For example, what do we do when the battery gets low? If
> the user has said to suspend the system when battery reaches 10%, then
> ospmd needs to track that and make it happen at the right time.

Ok. I understand now that I somehow missed the point. It seems to be a
good idea to complete the design of the gui pm control panel or the
libpower API. Would you think you have some time in the near future to
do one of those? Otherwise I could do some work on such a gui program by
taking the small pm-control-applet which was pre-installed on my vaio
under windows and the existing gui as a start...though I would rather
like to do it in gnome/gtk since I am not that familiar with QT. 


-Knut
-- 
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Physikalische Grundpraktika - Heinrich-Heine Universitaet Duesseldorf
Raum 25.33.01.63  -   Universitaetsstrasse 1   -  D-40225 Duesseldorf
fon: +49-211-81-11314                           fax: +49-211-81-13105











-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
