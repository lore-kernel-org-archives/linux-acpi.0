From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: driver 8139too prevents swsusp.
Date: Mon, 10 Feb 2003 11:54:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030210105427.GB25625@poup.poupinou.org>
References: <20030208091526.GA20891@lps.ens.fr> <m2isvur153.fsf@bukitingi.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2isvur153.fsf-YtnopudCPpKZc+EVdkgb/uuF24qua0Fl0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Chmouel Boudjnah <chmouel-FOUw8OHuoQdBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Feb 08, 2003 at 09:03:04PM +0100, Chmouel Boudjnah wrote:
> Éric Brunet <ebrunet=l5PIGlIYzrxGWvitb5QawA@public.gmane.org> writes:
> 
> > Indeed, I have a kernel thread called [eth0] in the ps output. I cannot
> > kill this process, but if I do ``ifconfig eth0 down'', the process
> > diseapear and the swsusp works better (see below). So it seems that
> > swsusp cannot put this [eth0] process in the refrigerator.
> 
> why dont you patch the script to make a ifconfig eth0 down and
> ifconfig eth0 up on wakeup (or whatever like restart network on your
> distriution) ?
> 

This is for 2.5 for which we want better solutions to do that.
No more modules insmod/rmmod horror.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
