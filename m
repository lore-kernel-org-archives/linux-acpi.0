From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: how to get Fn key working on compaq 2100/2110
Date: Mon, 23 Jun 2003 11:28:54 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030623092854.GT19556@poupinou.org>
References: <Law9-F13aCdhxJKocJq0002f84d@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Law9-F13aCdhxJKocJq0002f84d-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Cougle <dcougle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jun 22, 2003 at 01:40:51PM -0500, David Cougle wrote:
> cat /proc/acpi/sleep
> S0 S3 S4 (swsusp) S5
> 
> I just have heard of people who are able to skip past kernel and force 
> suspend to ram.
> was wondering if i could do this.
> 

I had a patch one year ago.  But it was really too buggy.  I even
don't know if it worked properly due to lack of hardware...
Anyway, even if that patch worked, all the power management
of the devices in linux 2.4 in general have to be rewrotten.

I don't think the cost of the time of this rework for 2.4 will be really
usefull, since linux 2.5 have already a framework for this purpose.
And this work will be too oriented to developpement, not improving
things or write a new driver, etc.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
