From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Mon, 13 Oct 2003 15:38:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031013133837.GA9178@hell.org.pl>
References: <20031003193814.GE205@openzaurus.ucw.cz> <20031006124935.GQ11391@poupinou.org> <20031006130533.GA311@elf.ucw.cz> <20031008102745.GF11391@poupinou.org> <20031008191610.GB1035@elf.ucw.cz> <20031008215342.GE1920@fairlite.demon.co.uk> <20031008215850.GF1238@elf.ucw.cz> <20031009140648.GH1922@fairlite.demon.co.uk> <20031009213504.GC365@elf.ucw.cz> <20031013131022.GN11391@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031013131022.GN11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Ducrot Bruno:
> That exactly my point.  And I think it should not do full save/restore
> on only VT switch, but we may try to have a better fine grained stuff for,
> something like 'hey, X we have to go S3, please consider'.

I second that. Sure, VT switch is necessary, but it takes quite a few
seconds, which is unacceptable for S1 for example (Radeon M7 needs the
restore after S1 too).
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
