From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: heatload 0.4 now with throttling support
Date: Thu, 19 Dec 2002 15:27:24 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021219152724.GA14703@clara.net>
References: <3E008120.5080908@uni-muenster.de> <20021218153355.GK347@poup.poupinou.org> <3E009EB5.7010109@muenster.de> <20021218170828.GA9127@clara.net> <3E00AEC8.9050906@muenster.de> <20021218180329.GA9439@clara.net> <20021219132303.GH4257@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021219132303.GH4257-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Malte Thoma <thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>, ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Ducrot Bruno [ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] wrote:
> > The only thing you can do is opendir("/proc/acpi/thermalzone"), then
> > readdir for each item - ignore . and .. of course.
> 
> No.  scandir().  You can alphasort.

Picky :)  What I was trying to say is that you've got no choice but to
scan/read directories, you can't hardcode.

Scandir is cute, but perhaps unnecessary in a procfs where the nodes are
created in-order anyway?


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

When it comes to broken marriages most husbands will split the blame --
half his wife's fault, and half her mother's.


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
