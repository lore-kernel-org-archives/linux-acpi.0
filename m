From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH][2.4] acpi S5 poweroff fix
Date: Fri, 2 May 2003 10:44:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502084450.GG2954@poup.poupinou.org>
References: <20030429181518.96485.qmail@web41601.mail.yahoo.com> <Pine.LNX.4.53.0304301628010.4213@dynast.gaugusch.at> <20030430193855.GA21497@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030430193855.GA21497-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 30, 2003 at 09:38:56PM +0200, Karol Kozimor wrote:
> Thus wrote Markus Gaugusch:
> > I think that the prevention of S5 is nonsense.
> > echo 5 > /dev/hda will screw up your system much more than echo 5 > sleep.
> > Root must know what he's doing. I think that the patch should be applied.
> 
> Some time ago (at least with acpi-20021212) this feature worked perfectly.
> It was then judged as dangerous and explicitly disabled in further releases.
> What you are trying to do, is to reverse this change, so basically, you'll
> probably not have much luck succeeding. Check the archives of the list (I 
> believe the topic was discussed around January).
> Best regards,

This was my fault(c)(TM) with s4bios.  A fix is the first
patch send by the original poster of this thread (or
one I have send to Andy some times ago which does the
same fix anyway).
But I have more concern with the second patch.
It break the CONFIG_ACPI_SLEEP option.

At this time, this option is always 'yes', but this may change
in the future, and we want to be able to enter S5 even if this
option is off (as in 2.5).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
