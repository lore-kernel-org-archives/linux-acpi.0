From: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: Re: [ACPI] laptop turns itself off
Date: Tue, 23 Jul 2002 20:33:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020723183320.GA25180@lps.ens.fr>
References: <20020710132039.B17998@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020710132039.B17998-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 10, 2002 at 01:20:39PM -0500, Bob McElrath wrote:
> I have a laptop that spontaneously turns itself off about once or twice
> a day.  It is an all-ACPI model from Compal model ACL00.  I understand
> it is equivalent to a Toshiba Satellite 3000 series.  The computer
> itself is the Emperor Linux model from http://www.aslab.com/.

I have the same problem with toshiba S3000-X11.

It happens even when the computer is cool. However, I think it is related to temperature:

I have spent some time looking at the temperature of the computer, as
reported by Bruno Ducrot's tosh300k module (the DSDT is buggued, so there
is no thermal zone unless you change it, which I haven't done yet)

The temperature behaves most of the time nicely: it increases slowly from
the lower value to the higher, then goes down quickly as the fan gets on.
However, at some times, the sensor report some aberrant value; like 15 or
20 or more degrees (Centigrade) off. It lasts for one or two seconds and
goes back to normal.

I believe that at some point, the grossely incorrect reported temperature
triggers the emergency shutdown.

I don't know what I should do. Is there a way to disable the emergency
shutdown (the fan works correctly, thank you) ? Is it possible to make
the emergency procedure average the temperature for 5 seconds before
deciding to shut down ? Is there a way to fix the sensors so that they
don't report wrong values ?

Of course, the other possibility is that the shutdown has nothing to do
with temperature, and that the wrong values reported by the sensors are
just a coincidence.

Eric Brunet


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
