From: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Subject: Re: Plea for help
Date: Sat, 20 Dec 2003 18:08:54 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031220180854.32e2f56d.rddunlap@osdl.org>
References: <3FE28F79.601@comcast.net>
	<3FE33B69.1010606@netspace.org>
	<3FE39231.4040003@comcast.net>
	<20031219160947.79c3fcdf.rddunlap@osdl.org>
	<3FE3A142.90407@comcast.net>
	<20031219184043.3983572d.rddunlap@osdl.org>
	<3FE4A740.4080701@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3FE4A740.4080701-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 20 Dec 2003 13:47:12 -0600 Ian Pilcher <i.pilcher-Wuw85uim5zDR7s880joybQ@public.gmane.org> wrote:

| Randy.Dunlap wrote:
| > 
| > and exactly what kernel version is this?
| > 
| 
| 2.4.23 with the 20031203 ACPI patch.  I get basically the same behavior
| with unpatched 2.4.23 or any of the Fedora Core kernels.

Good.  I only have unpatched 2.4.23 available currently (or 2.6.x).

Is there some reason that you build a kernel with both APM and ACPI
support?  Can you test it without APM support, to see if it changes any?

The dmesg files aren't complete boot logs.  Can you provide complete
boot logs for these 2 cases (panic & hang)?

--
~Randy


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
