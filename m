From: Malte Thoma <thoma-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
Subject: Re: performance problems?
Date: Mon, 16 Dec 2002 09:06:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3DFD896F.3020302@uni-muenster.de>
References: <Pine.LNX.4.44.0211191552030.31104-100000@dynast.gaugusch.at>
Reply-To: thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0211191552030.31104-100000-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Markus Gaugusch <markus-z+rTbpWsRgbk7+2FdBfRIA@public.gmane.org>
Cc: ACPI-Devel <Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Markus Gaugusch wrote:
> On Nov 19, Loic Jaquemet <ljaquemet-BNG0eM9rGRi0IRkH3yUr9EW4647UYGdYQQ4Iyu8u01E@public.gmane.org> wrote:
> 
>>i'am using 2.4.19 + around october patch ( I'll check that this evening )
>>on sony vaio fx502
>>[...]
>>when I fetch the /proc/acpi/<batteriesxxx>/state|info files, I get a 1-2
>>second freeze| lag ..
>>[...]
>>I'm not sure, but i think i didn't have this problem on pre-september
>>patches ..
> 
> No, it has been present before. I have an FX405 and can't use any battery
> monitor applet that reads the info file. Even a 'cat
> /proc/acpi/battery/BAT1/info' causes a noticable peak in my cpu monitor
> (kernel time). At least, it doesn't freeze keyboard anymore, thanks to the
> ACPI people!

You can try my 'heatload'. Because I have an Sony, too, I have made a 
workaround for the 'info'-File.
(I'm using an older ACPI-patch for kernel 2.4.18)


Greetings,

Malte




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
