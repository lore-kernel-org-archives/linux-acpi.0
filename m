From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: New SmartBattery DSDT-based controller
Date: Sun, 06 Feb 2005 16:52:22 -0500
Message-ID: <42069196.707@bartol.udel.edu>
References: <41FBDDE2.1050403@bartol.udel.edu> <m2mzuhz7pg.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <m2mzuhz7pg.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:
> 
> 
>>1) Direct fiddling with the SMBus registers that make up part of the EC
>>address space. This is what Bruno Ducrot's i2c-acpi-ec module was for:
>>it exposed kernel-space functions to allow one to perform the required
>>fiddling. My acpi-sbs module then used these functions to examine the
>>status of the smart battery.
> 
> 
> Actually, I think this approach has it attractive sides as well.
> I'm currently using your acpi-sbs snapshot of 20050120. Did you
> produce anything better before you switched to the DSDT approach?

No, I got sidetracked by the DSDT stuff (and by my 3 month-old daughter!).

However, I should mention that, long-term, I see the acpi-sbs module as 
*sort of* the way to go. But first, we need a proper framework for 
dealing with batteries under Linux, that exposes a unified interface to 
userspace. This framework would abstract away all of the hardware 
dependent stuff, so that whether a system has a CM battery or an SBS 
battery, it appears exactly the same outside the kernel. The "future" 
acpi-sbs module would be implemented as part of this framework, as would 
a new module for CM batteries.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
