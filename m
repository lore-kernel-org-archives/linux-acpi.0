From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: Re: ACPI / cpufreq on Compaq Presario R3120
Date: Thu, 03 Jun 2004 13:09:14 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40BF06DA.3020208@renninger.de>
References: <40BE9B24.6050504@pacific.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40BE9B24.6050504-s7p20SfEDVaVc3sceRu5cw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Ken,

there is a separate mailing list for cpufreq problems:

Cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
http://www.linux.org.uk/mailman/listinfo/cpufreq

      Thomas

Ken Hughes wrote:
> I've got a Presario with an AMD XP-M 3000+ CPU (a 32-bit K8).
> I can't get the acpi or powernow-k8 modules to load;  loading
> acpi gives this message:
> 
>  > acpi_processor_perf-0301 [1219] acpi_cpufreq_cpu_init : Unsupported 
> address space [127, 127]
> 
> and powernow-k8 gives this:
> 
>  > powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 
> 1.20.08b - March 20, 2004)
>  > powernow-k8: Too many lo freq table entries
>  > powernow-k8: BIOS error - no PSB
> 
> I dumped the DSDT but it doesn't seem to have much info on the CPU.
> 
> Any suggestions where I should look? -- Ken
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
> 
>> From Windows to Linux, servers to mobile, InstallShield X is the one
> 
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
