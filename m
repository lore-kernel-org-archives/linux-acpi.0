From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Centrino speedstep
Date: Wed, 29 Dec 2004 19:18:34 +0100
Message-ID: <20041229181834.GA19199@poupinou.org>
References: <m2zmzyw4e7.fsf@phoenix.squirrel.nl> <20041228212653.GA8436@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041228212653.GA8436-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 28, 2004 at 10:26:53PM +0100, Dominik Brodowski wrote:
> On Tue, Dec 28, 2004 at 09:32:00PM +0100, Johan Vromans wrote:
> > Hi,
> > 
> > On my Acer Travelmate 4000WLMi, with various 2.6.9 and 2.6.10 kernels
> > and patch sets, I keep getting the following message:
> > 
> >   speedstep-centrino: invalid ACPI data
> >   speedstep-centrino: no table support for CPU model "Intel(R) Pentium(R) M processor 1.50GHz": 
> > 
> > (Some kernels report "Invalid control/status registers" instead of
> > "invalid ACPI data").
> > 
> > My latest attempt was the stock 2.6.10 kernel, with ACPI patch set
> > acpi-20041210-2.6.10-rc3.diff, and a fixed DSDT. Still no success.
> > 
> > Any help is appreciated.
> 
> It looks like your notebook's BIOS does not report sufficient data to the
> speedstep-centrino cpufreq driver. Does the acpi-cpufreq driver work
> instead?
> 

After looking the DSDT, this laptop do not support the _PDC switch, so
the cpufreq-centrino driver will not work.  But it should work with the
acpi io driver though.

Interresting portion:

    OperationRegion (MNVS, SystemMemory, 0x1FEECE59, 0x60)
    Field (MNVS, AnyAcc, Lock, Preserve)
    {
        ...
        ...
        CLNM,   8,
        ...
    }

        Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06)
        {
            Name (_PCT, Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B2)
                },

                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B3)
                }
            })
            Method (_PSS, 0, NotSerialized)
            {
                If (CLNM)
                {
                    Return (CPSS)
                }

                Return (PPSS)
            }

            Name (CPSS, Package (0x01)
            {
                Package (0x06)
                {
                    0x0640,
                    0x5DC0,
                    0x0A,
                    0x0A,
                    0x89,
                    0x00
                }
            })
            Name (PPSS, Package (0x05)
            {
                ... (follow 5 packages defining the 5 P-states)
            }
            })
            Method (_PPC, 0, NotSerialized)
            {
                Return (0x00)
            }
        }


This also mean there is no way to get the ondemand governor (or any DVS
requiring low latency driver) to work with this one (unless hardcoding
a table in the cpufreq-centrino).

There is no _CST also, this means there is no C4 support :(

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
