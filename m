From: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
Subject: Re: Re: [2.6.6] Synaptics driver is 'jumpy'
Date: Mon, 17 May 2004 14:43:35 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1084830215.27780.25.camel@journeyhawk.localdomain>
References: <200405161222.48581.lkml@kcore.org>
	 <200405170832.32256.lkml@kcore.org>
	 <200405170142.41289.dtor_core@ameritech.net>
	 <200405170904.24471.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200405170904.24471.lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Re:
http://sourceforge.net/mailarchive/forum.php?thread_id=4172848&forum_id=6102

A BIOS upgrade from the laptop manufacturer has cured the problem
entirely.  I am now able to run the battery monitor with no effect on
keyboard or touchpad pointer.  I don't know what they changed, but
whatever it was, it's fixed now.  I suppose that it could be a change to
the Linux ACPI code that fixed it, but I suspect it was the BIOS update.
It's a "you tell me and we'll both know" situtation -- I've only just
begun learning about the internals of how ACPI works.

-- 
Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
