From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: General Questions:
Date: Fri, 04 Feb 2005 09:47:32 -0500
Message-ID: <42038B04.8070908@bartol.udel.edu>
References: <1107520354.4248.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107520354.4248.16.camel@localhost>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: jeremy-9vekgGPT+OA7YuNMryXyOw@public.gmane.org, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Jeremy Moles wrote:
> Hello again ACPI gurus! Many thanks for the last tip; I was able to
> decompile and "fix" the DSDT rather easily using the advice from your
> responses.
> 
> I have a few questions about batteries:
> 
> I was looking around the battery driver code last night trying to find
> out what the battery "alarm" actually does. Unfortuneately (and I only
> spent a few minutes looking), I wasn't able to easily see what the
> function of this feature was. I guess my first question is: does it do
> anything at all? :)

The 'alarm' feature implemented in Linux is actually mapped to the _BTP 
(battery trip point) of the ACPI specification. Section 10.2.2.4 of this 
spec indicates that a notify must be issued when the battery remaining 
capacity crosses this alarm level (either falling below or rising above).

When the battery receives this notification, it dispatches a battery 
event, which shows up in /proc/acpi/events. What action is taken on this 
event is up to whatever userspace application you are using. I myself 
have configured acpid so that when a battery event is read, AND the 
system is on battery power, AND the remaining capacity is below the 
alarm level, the system automatically suspends (using swsusp2).

> 
> Secondly, would it be beyond of the scope of ACPI for the battery driver
> to generate ACPI events when the power gets low? Or is there already
> something like this that exists that I'm missing? I tried
> watching /proc/acpi/event last as my battery discharged and didn't see
> any unusual activity.

As per the stuff above, there is already stuff there. However, it only 
works through the _BTP functionality. If this functionality is not 
implemented in the DSDT -- or if the alarm level is set crazy low -- 
then you lose the capability to get advanced warning of low-power 
situations.

> 
> Thirdly, does the kernel have access to the LED lights on a typical
> laptop? That is, does it have the ability to ping the LED and make it
> light up? Or, is that something controlled entirely by hardware? It
> would be rather neat, I think, to use my "bluetooth" LED (since I don't
> have bluetooth) in an arbitrary way.

This really depends on the laptop in question. Do you by any chance have 
an Acer? My Acer TM4502 has an unused bluetooth LED/button, and I think 
there *might* be a way to control it through the BIOS (see recent posts 
by Johan Vromans).

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
