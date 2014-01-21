From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v3] ACPI / video: Add systems that should
 favor native backlight interface
Date: Tue, 21 Jan 2014 13:32:42 +0800
Message-ID: <52DE067A.60400@intel.com>
References: <1390053249-18919-1-git-send-email-i.gnatenko.brain@gmail.com>	
	<52DCDA75.2000108@intel.com> <1390224857.10605.0.camel@x230>	
	<52DDDA64.90407@intel.com> <1390274270.5320.2.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1390274270.5320.2.camel@x230>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "james@albanarts.com" <james@albanarts.com>, "bitbucket@online.de" <bitbucket@online.de>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "hmh@hmh.eng.br" <hmh@hmh.eng.br>, "kvalo@adurom.com" <kvalo@adurom.com>, "corsac@debian.org" <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "ben@bjencks.net" <ben@bjencks.net>, "jrg.otte@gmail.com" <jrg.otte@gmail.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Martin@lichtvoll.de" <Martin@lichtvoll.de>, "thirdwiggin@gmail.com" <thirdwiggin@gmail.com>, "bugs@ttyhoney.com" <bugs@ttyhoney.com>, "jplatte@naasa.net" <jplatte@naasa.net>, "seth.forshee@canonical.com" <se>
List-Id: linux-acpi@vger.kernel.org

On 01/21/2014 11:17 AM, Matthew Garrett wrote:
> On Tue, 2014-01-21 at 10:24 +0800, Aaron Lu wrote:
>> On 01/20/2014 09:34 PM, Matthew Garrett wrote:
>>> On Mon, 2014-01-20 at 16:12 +0800, Aaron Lu wrote:
>>>
>>>> 1 remove the win8 OSI check, I've seen win7 laptops that also needs to
>>>>   have only the GPU interface left and checking win8 doesn't make much
>>>>   sense now;
>>>
>>> Are we sure that those aren't simply some other bug?
>>
>> Well, the firmware on that laptop makes use of EC to do backlight
>> control and the fact that the firmware interface doesn't work while the
>> GPU's work seems to indicate that the backlight control circuit is not
>> routed to EC. I think this is the same case as Win8 laptops.
> 
> We know that Windows 8 graphics drivers don't use the ACPI interface,
> and that systems change their behaviour as a result, in some cases with
> absolutely no way for the ACPI interface could possibly work. I haven't
> seen any cases where that's obviously true for any non-Windows 8

Perhaps I'm not clear, I didn't mean non-Windows 8 systems will all favor
GPU's interface, I just meant for one specific win7 laptop I could re-use
the existing code to make the GPU's interface as the only one left. And to
achieve this, the Win8 OSI check in acpi_video_verify_backlight_support
has to be gone.

BTW, I actually think use_native_backlight param should mean "the native
backlight control interface will be the only one available on the system",
it doesn't need to go side by side with Win8 OSI check.

> systems. EC interfaces that don't work are often due to Linux leaving
> the hardware in a state other than the one expected by the firmware. We

Good to know this, thanks.

> shouldn't assume that it's the same issue until we've investigated
> further.

OK, but I honestly don't have any idea how to proceed, in case you have
some time, the bug is:
https://bugzilla.kernel.org/show_bug.cgi?id=66501
