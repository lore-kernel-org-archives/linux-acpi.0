From: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Subject: Re: Applications & ACPI eventse
Date: Fri, 10 Oct 2003 14:37:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F86A7F7.6090406@basmevissen.nl>
References: <20031006124935.GQ11391@poupinou.org> <20031006130533.GA311@elf.ucw.cz> <20031008102745.GF11391@poupinou.org> <20031008191610.GB1035@elf.ucw.cz> <20031008215342.GE1920@fairlite.demon.co.uk> <20031008215850.GF1238@elf.ucw.cz> <20031009123620.GD13739@hell.org.pl> <20031009213245.GB365@elf.ucw.cz> <20031009235607.GA13514@hell.org.pl> <20031010071231.GA285@elf.ucw.cz> <20031010111934.GA10620@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031010111934.GA10620-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor wrote:
> 
> But the DRI engine is not, so switching back to unpatched XFree86-4.3.0
> after resume corrupts the display and does other not-so-nice things.
> 
> The S4 example was merely to illustrate what the radeon driver does.
> 

Ah, maybe that is my problem with S4 suspend (swsuspend actually). I 
thought installing the binary release (containing kernel driver (build 
from source) and XFree patches) was enough. But do I need other things too?

What do I need (starting with a clean X install from Red Hat 9) to get a 
proper resuming (from S3 and S4) X with a radeon video card? Is the 
agpgart from kernel 2.4.22 new enough?

Bas.





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
