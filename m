From: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>
Subject: Re: 2.5.64-bk4: Is CONFIG_ACPI_NUMA for IA64 only?
Date: Mon, 10 Mar 2003 17:04:45 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030310.170445.104032756.kochi@hpc.bs1.fc.nec.co.jp>
References: <200303091951.LAA02649@adam.yggdrasil.com>
	<20030310.160402.71090529.kochi@hpc.bs1.fc.nec.co.jp>
	<80320000.1047280489@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <80320000.1047280489-oRem06ootMAo6foR4HHleQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org
Cc: adam-7x81iamSd18S+FvcfC7Uqw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

From: "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [ACPI] 2.5.64-bk4: Is CONFIG_ACPI_NUMA for IA64 only?
Date: Sun, 09 Mar 2003 23:14:50 -0800
Message-ID: <80320000.1047280489@[10.10.2.4]>

> >> 	Anyhow, I'm not sure if the call to acpi_numa_slit should be
> >> commented out for non-ia64 architectures or if CONFIG_ACPI_NUMA should
> >> be changed to depend on CONFIG_IA64, or if something else should be
> >> done.
> > 
> > The problem here is that only a callback routine for SRAT is implemented
> > in i386 but one for SLIT is not.  So I think it's better to have
> > suboption CONFIG_ACPI_SLIT for CONFIG_ACPI_NUMA, which is only
> > configurable on ia64 currently (if some x86 platform implements
> > the SLIT table, we should change accordingly).
> 
> That's a lot of config options ;-) As long as they're hidden from the
> user, I guess it doesn't matter (too many questions just makes people
> spontaneously combust). Presumably it's derivable from CONFIG_NUMA,
> CONFIG_ACPI, and the machine type ... so we can just "do the right thing"?
> Or is there still some other reason to turn CONFIG_ACPI_NUMA on and
> off independantly for users?

Okay, for users, I agree it's not comfortable to check whether
the SLIT table is implemented or not.

Again, the problem is that full callback routines are not implemented
in i386 arch specific code.  To avoid making another config options,
I'd like to use weak symbols or function pointers for those functions
and callback only when those are implemented.
Then the configuration can be automated...

Thanks,
---
Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org/t-kochi@bq.jp.nec.com>


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
