From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Sat, 20 Nov 2004 03:32:40 +0000
Message-ID: <20041120033240.GJ1108@parcelfarce.linux.theplanet.co.uk>
References: <3ACA40606221794F80A5670F0AF15F84041AC098@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC098@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 19, 2004 at 12:41:54AM +0800, Yu, Luming wrote:
> 1. Current ACPI CA seems to have defect when handling
> case if there have duplicate GPE interrupt level. 
> It's due to all acpi_gpe_xrupt_info
> are hooked onto a global list of acpi_gbl_gpe_xrupt_list_head. 
> And, if found a duplicate interrupt, the old acpi_gpe_xrupt_info
> will be override by new one, Please take a look at 
> acpi_ev_get_gpe_xrupt_block. So you patch need to avoid
> duplication of GPE interrupt level at this moment.
>  I'm not sure if this limitation is NOT ACPI CA 's bug. ( I will figure
> it out)

I think this is just a misreading.  There's one acpi_gpe_xrupt_info per
interrupt.  There can be multiple gpe blocks per acpi_gpe_xrupt_info.
See acpi_ev_install_gpe_block():

        gpe_xrupt_block = acpi_ev_get_gpe_xrupt_block (interrupt_level);
        acpi_os_acquire_lock (acpi_gbl_gpe_lock, ACPI_NOT_ISR);
        if (gpe_xrupt_block->gpe_block_list_head) {
                next_gpe_block = gpe_xrupt_block->gpe_block_list_head;
                while (next_gpe_block->next) {
                        next_gpe_block = next_gpe_block->next;
                }

                next_gpe_block->next = gpe_block;
                gpe_block->previous = next_gpe_block;
        }
        else {
                gpe_xrupt_block->gpe_block_list_head = gpe_block;
        }

> 2. Due to the global list of acpi_gbl_gpe_xrupt_list_head,
> All GPEs will be checked at each GPE interrupt level,
> This is not the expected behaviour of just checking GPE at GPE's
> interrupt
> level.

I think this misunderstanding follows from the above misunderstanding.

> 3. Interrupt Source Overrides are necessary to describe variances 
> between the IA-PC standard dual 8259 interrupt definition and the 
> platform's implementation.
> 
> Please take a look at ACPI SPEC
> 5.2.11.8   Interrupt Source Overrides

OK, but that doesn't explain why we have two copies of the FADT.  Or,
for that matter, why we only override SCI INT in one copy of the FADT
and not the other.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
