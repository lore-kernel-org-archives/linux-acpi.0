From: Miroslav Ruda <ruda@ics.muni.cz>
Subject: Re: suspend to RAM on lifebook 7110
Date: Mon, 18 Dec 2006 17:53:02 +0100
Message-ID: <4586C76E.5000105@ics.muni.cz>
References: <20061207221831.GA31419@erebor.ics.muni.cz>
	<20061218063816.GE26170@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061218063816.GE26170@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Stefan Seyfried wrote:
> Hi Miroslav,
> 
> i'm taking suspend-devel into cc:, maybe somebody there has an idea about
> this, too.
> 
> On Thu, Dec 07, 2006 at 11:18:31PM +0100, Miroslav Ruda wrote:
>> Hi,
>>
>>  I'm installing opensuse 10.2 on Fujitsu Siemens Lifebook 7110 (intel
>> dual core, intel 965 chipset, intel 945 graphics chipset ...).
>> Most of hardware works fine, but I have some problems with suspend to
>> ram - suspend/resume using s2ram works fine, but display remains nearly 
>> black. I can see very hardly what's on display, but machine including
>> network works fine.
> 
> So the graphics card is back up, it is really just the backlight that stays
> off.
> 
>> I have tested s2ram on Suse 2.6.18.2-23-default or vanila 2.6.19+swsusp2
>> with the same problems.
>>
>> s2ram -i returns
>> This machine can be identified by:
>>     sys_vendor   = "FUJITSU SIEMENS"
>>     sys_product  = "LIFEBOOK S7110"
>>     sys_version  = " "
>>     bios_version = "Version 1.18 "
>>
>> s2ram -f -a[0123] gives the same result, -s -p combinations doesn't work
>> too. Switching back to text console doesn't help. Using xset dpms force
>> off doesn't help too. The same problem I have both on text console and
>> using Xserver.
> 
> Does this machine have fn-keycombos for adjusting the screen brightness?
> Try those. I have seen a FSC Q-series (?) that needed just one touch of
> the brightness-up key to turn back on the light.
> 
> Once we realized this, we could also poke it via the ACPI video module
> (just increase the brightness by one level, then decrease it again) and
> this also switched the light back on.

Fn-brightness-down (really down, not up) helps me with the same problem 
on older Lifebook S7020 (i915 chipset). However, on Lifebok S7110 non of
Fn- keys or switching off/on display does the same trick :-(

              Miroslav Ruda

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
