From: "David Cougle" <dcougle-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RE: how to get Fn key working on compaq 2100/2110
Date: Tue, 24 Jun 2003 13:08:48 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <001701c33a7b$a89ff6f0$3201a8c0@pamlab.com>
References: <20030623092026.GS19556@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030623092026.GS19556-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Is this to say that with 2.5/2.6 my Compaq 2100/2110 will bypass kernel
and suspend to ram? How do I see if it supports that?  I am running
acpid.

-----Original Message-----
From: Ducrot Bruno [mailto:ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 
Sent: Monday, June 23, 2003 3:20 AM
To: David Cougle
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] how to get Fn key working on compaq 2100/2110

On Sun, Jun 22, 2003 at 10:51:54AM -0500, David Cougle wrote:
> nevermind, it works, but fn plus suspend key does nothing.
> does this mean my compaq 2100/2110 does not have suspend to ram?

S3 (aka suspend to ram) is not supported in Linux 2.4, but even
though it was the case, you have to install a little daemon called
acpid.

In all case, you can test if at least this key work by
cat /proc/acpi/events
then press fn-suspend and see if an event is recorded.
Then, via acpid, you can actually do what you want, by
writting a little shell script in order to handle this key.

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
