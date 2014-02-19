From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v4] ACPI / video: Add systems that should
 favour native backlight interface
Date: Wed, 19 Feb 2014 10:57:13 +0800
Message-ID: <53041D89.2050204@intel.com>
References: <5302F58C.1080001@intel.com> <20140218103442.GS5018@intel.com>
	<s5hfvngy2bh.wl%tiwai@suse.de> <1903167.TtlOFgMB6X@vostro.rjw.lan>
	<20140218154640.GT5018@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140218154640.GT5018@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Theodore Tso <tytso@mit.edu>, Kevin Smith <thirdwiggin@gmail.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Peter Weber <bugs@ttyhoney.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vladimir Sherenkov <a_12300@mail.ru>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Christensen <christensenthomas@gmail.com>, Lennart Poettering <lennart@poettering.net>, sov.info@mail.ru, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 02/18/2014 11:46 PM, Mika Westerberg wrote:
> On Tue, Feb 18, 2014 at 04:22:27PM +0100, Rafael J. Wysocki wrote:
>> On Tuesday, February 18, 2014 02:31:46 PM Takashi Iwai wrote:
>>> At Tue, 18 Feb 2014 12:34:42 +0200,
>>> Mika Westerberg wrote:
>>>>
>>>> On Tue, Feb 18, 2014 at 01:54:20PM +0800, Aaron Lu wrote:
>>>>> +	{
>>>>> +	.callback = video_set_use_native_backlight,
>>>>> +	.ident = "HP EliteBook 2013 models",
>>>>> +	.matches = {
>>>>> +		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>>>>> +		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook "),
>>>>> +		DMI_MATCH(DMI_PRODUCT_NAME, " G1"),
>>>>> +		},
>>>>> +	},
>>>>
>>>> I see my device is listed here but the above doesn't really use native
>>>> backlight because it is still in acpi_osi blacklist. Tried this and I can
>>>> see both acpi_video0 and intel_backlight listed under /sys/class/backlight.
>>>> Was this the intention?
>>>
>>> The acpi_osi blacklist commit (2d4054d84224) has to be reverted, as I
>>> mentioned earlier.  But the revert can be done individually after
>>> merging this patch.  Rafael, could you care?
>>
>> Done.  Please check the result in linux-pm.git/linux-next.
> 
> With your revert and this patch from Aaron, backlight on my HP EliteBook
> Revolve G1 works fine, thanks!
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for the test Mika and sorry for all the confusions caused.

-Aaron
