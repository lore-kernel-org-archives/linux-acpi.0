From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Patch for ospmd thermal gui
Date: Mon, 31 Mar 2003 10:36:05 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A23D@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Knut Neumann [mailto:knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org] 
> as you suggested last year I made the ospmd_gui have a 
> thermal page. Now
> I found the time to clean the patch up and send it to you.

Thanks!

(BTW we are going to switch from the ACPI CA license to the BSD license,
is that OK with you?)

> I always thought to transparently export the acpi interface through
> ospmd/libpower. That is why I made one struct (PM_THERMAL_DATA) per
> zone. Now that seems plain wrong to me.
> 
> As I understand today you want ospmd to gather those 
> information needed
> for power management (policies) from /proc/acpi and export control of
> ospmd via libpower - is that right?

Yes. I'm assuming the user will be using a GUI-specific PM control panel
program, so my thought was that all these would act on the same power
policy by using libpower to talk to ospmd. This makes the interface
libpower exposes VERY IMPORTANT. It should not change once we lock it
down. I think at some point we need to review it (does it have enough
information? Too much?). IIRC we also are using internal data structures
in it, so we will probably want to fix that.

> In conclusion that would rather mean to have access to eg cooling
> mode/temperature (in ospmd _and_ libpower) via:
> 
> pm_set_thermal_cooling
> pm_get_thermal_cooling
> pm_get_thermal_temperature
> 
> to be able to either set cooling mode from the gui directly or have a
> policy in ospmd that eg switches cooling mode to active when a certain
> temperature is reached.

Well, cooling mode is only supposed to be specified by the user, so I
don't think ospmd would change it by itself. However, there is a lot of
room for ospmd to take the user's preference and then do the right thing
based on that. For example, what do we do when the battery gets low? If
the user has said to suspend the system when battery reaches 10%, then
ospmd needs to track that and make it happen at the right time.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
