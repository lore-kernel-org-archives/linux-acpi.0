From: "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>
Subject: Re: 2.5.64-bk4: Is CONFIG_ACPI_NUMA for IA64 only?
Date: Sun, 09 Mar 2003 23:14:50 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <80320000.1047280489@[10.10.2.4]>
References: <200303091951.LAA02649@adam.yggdrasil.com> <20030310.160402.71090529.kochi@hpc.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030310.160402.71090529.kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>, adam-7x81iamSd18S+FvcfC7Uqw@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> 	linux-2.5.64-bk4 adds a CONFIG_ACPI_NUMA option, which causes
>> some code to be compiled in that references acpi_numa_slit_init, which
>> is apparently only defined for ia64.  For the URL given in the comment
>> above acpi_numa_slit_init in arch/ia64/kernel/acpi.c, it looks like
>> the facility may be ia64 specific, but maybe it is just a standard
>> that originated with ia64 but is not ia64-specific:
> 
> drivers/acpi/Kconfig of recently refreshed 2.5 bk tree says:
> 
> config ACPI_NUMA
> 	bool "NUMA support" if NUMA && (IA64 && !IA64_HP_SIM || X86 && ACPI && !ACPI_HT_ONLY)
> 	default y if IA64 && IA64_SGI_SN
> 
> It seems like NUMA for X86 is supported...
> 
> These structures (SRAT and SLIT tables) are cpu-independent
> so theoretically they can be implemented on x86 hardware and
> I think some IBM hardwares have either or both of them.
> 
> (Judging from arch/i386 code & Kconfig, IBM x440 seems to implement
>  SRAT table)

It does, but uses a seperate (but derived) code base.
 
>> 	Anyhow, I'm not sure if the call to acpi_numa_slit should be
>> commented out for non-ia64 architectures or if CONFIG_ACPI_NUMA should
>> be changed to depend on CONFIG_IA64, or if something else should be
>> done.
> 
> The problem here is that only a callback routine for SRAT is implemented
> in i386 but one for SLIT is not.  So I think it's better to have
> suboption CONFIG_ACPI_SLIT for CONFIG_ACPI_NUMA, which is only
> configurable on ia64 currently (if some x86 platform implements
> the SLIT table, we should change accordingly).

That's a lot of config options ;-) As long as they're hidden from the
user, I guess it doesn't matter (too many questions just makes people
spontaneously combust). Presumably it's derivable from CONFIG_NUMA,
CONFIG_ACPI, and the machine type ... so we can just "do the right thing"?
Or is there still some other reason to turn CONFIG_ACPI_NUMA on and
off independantly for users?

M.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
