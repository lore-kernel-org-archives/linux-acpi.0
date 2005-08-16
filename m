From: Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org>
Subject: Re: Re: Centrino not scaling to lowest frequency
Date: Tue, 16 Aug 2005 11:28:20 +0200
Message-ID: <200508161128.20966.fexpop@onlinehome.de>
References: <200508152344.11572.fexpop@onlinehome.de> <m2u0hqqni1.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2u0hqqni1.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thanks Johan,

actually I'm quite sure that the CPU frequencies in the DSDT are wrong. 
Unfortunately I can't figure out where they are defined in the DSDT. 

Neither the dissassembled original DSDT nor the custom one (which adds battery 
read-out support) contain any _PSS entries. Isn't that what I should be 
looking for?

Where else might frequencies be defined in the DSDT?

Thanks again,

Felix

On Tuesday 16 August 2005 10:44, Johan Vromans wrote:
> Felix Homann <fexpop-53koH/AXb86i2/dY4+mD5w@public.gmane.org> writes:
> > $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> > 1600000 1333000 1067000 800000
>
> On my Acer Travelmate 4001WLMi the CPU frequencies in the DSDT were
> wrong. Did you check you have the right DSDT and frequencies?
>
> -- Johan
>
> See also:
> http://www.squirrel.nl/people/jvromans/articles/TM4001WLMi/acpi/speedstep.h
>tml


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
