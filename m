From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Suggestion for improving the handling of GPE enabling.
Date: Wed, 09 Mar 2005 09:31:37 +0800
Message-ID: <1110331896.12642.16.camel@sli10-desk.sh.intel.com>
References: <1110318037.3663.19.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110318037.3663.19.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-03-09 at 06:23, Nigel Cunningham wrote:
> Hi all.
> 
> Thinking about this GPE enabling issue some more, I'm wondering if the
> best solution would be to switch the enabling/disabling to be a
> handler
> registered with the driver model. In this way, the action taken could
> be
> better tied to what's actually happening (I'm assuming Pavel's
> pm_message_t changes are applied). Something like:
> 
> PMSG_FREEZE: Disable GPEs.
> PMSG_SUSPEND: Enable wake GPEs.
> PMSG_ON: Disable wake GPEs, enable normal GPEs.
I have the same feeling. A real solution should be to merge ACPI device
into the global device tree, so every ACPI driver will have a
.suspend/.resume method. In the .suspend/.resume method, we can do
anything we want. This has been in the wish list for a long time.
Some issues are:
1. what kind of device should ACPI device be? system device or platform
device?
2. What's purpose of the current ACPI namespace in sysfs? Could ACPI
device be regarded as a normal device?
3. Some ACPI devices have physical partners. Who will do the
suspend/resume?
4. ACPI devices are in many different physical buses. If we just define
an ACPI bus, we possibly can't show the bus hierarchy.


Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
