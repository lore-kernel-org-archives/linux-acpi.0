From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: heatload 0.4 now with throttling support
Date: Thu, 19 Dec 2002 16:39:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021219153945.GI4257@poup.poupinou.org>
References: <3E008120.5080908@uni-muenster.de> <20021218153355.GK347@poup.poupinou.org> <3E009EB5.7010109@muenster.de> <20021218170828.GA9127@clara.net> <3E00AEC8.9050906@muenster.de> <20021218180329.GA9439@clara.net> <20021219132303.GH4257@poup.poupinou.org> <20021219152724.GA14703@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021219152724.GA14703-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>, ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 19, 2002 at 03:27:24PM +0000, Faye Pearson wrote:
> Ducrot Bruno [ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] wrote:
> > > The only thing you can do is opendir("/proc/acpi/thermalzone"), then
> > > readdir for each item - ignore . and .. of course.
> > 
> > No.  scandir().  You can alphasort.
> 
> Picky :)  What I was trying to say is that you've got no choice but to
> scan/read directories, you can't hardcode.
> 
> Scandir is cute, but perhaps unnecessary in a procfs where the nodes are
> created in-order anyway?

Nope.  I really need to scandir() especially for the batteries case, because
the opendir() gave me BAT2 then BAT1 at least for me.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
