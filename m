From: Al Stone <astone@redhat.com>
Subject: Re: [RFC PATCH 0/4] Add ACPI support for pinctrl configuration
Date: Tue, 5 Apr 2016 18:00:31 -0600
Message-ID: <5704519F.5030906@redhat.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <20160404225200.GA1615@svinekod>
 <D3292CBB.662A8%charles.garcia-tobin@arm.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <D3292CBB.662A8%charles.garcia-tobin@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Irina Tirdea <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Octavian Purdila <octavian.purdila@intel.com>, Cristina Ciocan <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 04/05/2016 02:56 AM, Charles Garcia-Tobin wrote:
> 
> 
> On 04/04/2016 23:52, "Mark Rutland" <mark.rutland@arm.com> wrote:
> 
>> Hi,
>>
>> On Thu, Mar 31, 2016 at 02:44:41PM +0300, Irina Tirdea wrote:
>>> This is a proposal for adding ACPI support for pin controller
>>> configuration.
>>>
>>> It has been developed to enable the MinnowBoard and IoT community
>>> by providing an easy way to specify pin multiplexing and
>>> pin configuration.
>>>
>>> This proposal is based on using _DSD properties to specify device
>>> states and configuration nodes and it follows closely the device
>>> tree model. Device states are defined using the Device Properties
>>> format and the configuration nodes are defined using the
>>> Hierarchical Properties Extension format. The generic properties
>>> for the configuration nodes are the same as the ones for device
>>> tree, while pincontroller drivers can also define custom ones.
>>
>>From a look of the Documentation addition, and of the current uses of
>> pinctrl-names in device tree bindings, one reason for requiring multiple
>> pinctrl states is power management. Given that, I'm somewhat concerned by
>> this,
>> as it goes against the usual ACPI model of abstracting this sort of thing
>> behind power control methods.
>>
>> To the best of my knowledge, that goes against the ASWG's expectations on
>> how
>> _DSD will be used (per [1]). Charles, please correct me if that document
>> is no
>> longer representative.
> 
> It is though latest version was posted by Rafael a bit later:
> https://lists.acpica.org/pipermail/dsd/2015-December/000027.html
> 
> 
> In addition the core rules requiring that existing ACPI paradigms are not
> subverted through DSD (basically the concern you express) are also
> documented in the main DSD documentation itself:
> http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UU
> ID.pdf (section 2.3)

I have to echo Mark's concern: wholesale importation of portions of current
DT bindings simply because it's expedient is one of the things I've been hoping
to avoid.  These patches seem to be just that.

And while the latest version mentioned above describes a bit of a review
process to handle this case, I don't recall the kernel community at large
agreeing to it, nor to it having been implemented.  If I missed that part,
my apologies; please let me know where it was decided.  If I haven't, then
perhaps this needs to be the first test case of that process.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
