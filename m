From: "Martin J. Bligh" <Martin.Bligh-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: RE: [Discontig-devel] RE: Cleanup of NUMA support in ACPI
Date: Mon, 19 Aug 2002 10:43:57 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <2558610000.1029779037@flay>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDAE@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDAE-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> The strange thing is that ia32 doesn't have CONFIG_NUMA, it has
> CONFIG_MULTIQUAD. Are these equivalent, or more importantly, do they imply
> the use of SLIT and SRAT?

We do have CONFIG_NUMA when we do discontigmem support (see the
patches in akpm's tree). CONFIG_MULTIQUAD is just h/w stuff for the NUMA-Q
but we do not really do NUMA aware mem in the main tree.

NUMA-Q does not use SLIT/SRAT, but x440 will use them in conjunction with
CONFIG_NUMA (it's another ia32 NUMA platform). John Stultz (cc'ed) is
working on that.

M.




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
