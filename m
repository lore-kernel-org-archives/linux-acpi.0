From: wwp <subscript-GANU6spQydw@public.gmane.org>
Subject: Re: 2.4.24 patch apply failed on vanilla kernel
Date: Wed, 7 Jan 2004 15:53:25 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040107155325.5bfceba0@tethys>
References: <20040107134658.5afa9142.acpi@thermoman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040107134658.5afa9142.acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Marcel Meckel,


On Wed, 7 Jan 2004 13:46:58 +0100 Marcel Meckel <acpi-X2Xph2rMQzhn68oJJulU0Q@public.gmane.org> wrote:

> trying to patch 2.4.24 patch into a vanilla kernel results in 1
> reject:
> 
> patching file arch/i386/kernel/acpi.c
> patching file arch/i386/kernel/mpparse.c
> patching file arch/i386/kernel/smpboot.c
> Hunk #1 FAILED at 1106.
> 1 out of 1 hunk FAILED -- saving rejects to file
> arch/i386/kernel/smpboot.c.rej patching file arch/x86_64/kernel/acpi.c
> patching file drivers/acpi/Config.in
> patching file drivers/acpi/bus.c

It is like if the acpi patch is based on a 2.4.24+uv1 patch (that replaces the use
of NR_CPUS w/ BITS_PER_LONG). Quite easy to fix by hand, simply override
the for (..) line w/ the one provided by the acpi patch.


Regards,

-- 
wwp


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
