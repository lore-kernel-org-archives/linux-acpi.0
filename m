From: Vernon Mauery <vernux-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: ACPI S3 draws too much power on T40/T41
Date: Thu, 08 Jul 2004 13:58:24 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1089320304.2089.176.camel@bluerat>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

The following message was posted on the LKML not long ago.  I thought
that this mailing list might be a good forum to help in finding out the
cause for this.

Being rather new to this area (ACPI), I am not entirely sure of what
would be the cause of this.  My guess is that the drivers used for the
T40 are not power management aware and thus do not properly power down
the devices when entering S3.

Just out of curiosity, I checked to see how well it does in winXP and it
works fine there.  APM under Linux also works fine to suspend.  But S3
draws enough power to keep the laptop warm when it is asleep.  These
tests are what pushed me to the conclusion that the drivers are not PM
aware.

A bug has been opened by Volker Braun (the author of the forwared email)
on the bugme database: http://bugme.osdl.org/show_bug.cgi?id=3022

--Vernon

-----Forwarded Message-----
From: Volker Braun <volker.braun-DqRHhl98DdeAKZTfuerNgRvVK+yQ3ZXh@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Date: Tue, 06 Jul 2004 10:14:48 -0400

ACPI S3 draws too much power on the T40/T41, this has been confirmed by
various people (so its not just mine). Suspended it lasts about 10h,
about twice as long as powered up. Supposed to be 1-2 weeks. 

I guess we should have filed a bug report a long time ago. I'll do that
now.

If anybody has any tips on how to debug this (debug a suspended machine
:-) I would like to know.

Best,
Volker


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
