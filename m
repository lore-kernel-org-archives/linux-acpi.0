From: Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>
Subject: Re: C1VN, ACPI and ESD/ASD = const CPU
Date: Tue, 27 Aug 2002 15:58:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020827145843.GA12836@the.earth.li>
References: <20020827091844.7af7a982.jcollins@asgardsrealm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020827091844.7af7a982.jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
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

---- Original Message ----
> From Jamin W. Collins <jcollins-u0TlgVUp4POoiH3BShWgcg@public.gmane.org>
> Date: Tuesday, 27 Aug 2002, 15:18
> 
> CPU states:   0.8% user,  25.7% system,   0.0% nice,  73.5% idle
                            ^^^^^^^^^^^^
The marked bit means that 25.7% of the CPU time is being spent inside 
the kernel, this means that it doesn't show up on the process list as 
it is not a normal process causing the load ..  hence you weren't able 
to spot where it was being used even when sorting by CPU usage.

A traditional way to create a high system CPU load would be lots of
network traffic over an encrypted interface (e.g. cipe) .. so the kernel
itself is spending a lot of time doing cryptography.

The fact that ACPI is causing this is a problem.  One thing to try is 
check that you are not getting lots of ACPI events or that you are not 
getting lots of interrupts occuring.  The later can be found with 'cat 
/proc/interrupts' .. run it a few times and compare the results.

I'm not an ACPI expert so I can't suggest much else to look for.

-- 
Stephen White <stephen-acpi-devel-4QvXXjU8Dv4@public.gmane.org>


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
