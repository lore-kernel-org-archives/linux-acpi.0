From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH 1/3] nfit: Account for table size length variation
Date: Tue, 24 Nov 2015 11:24:00 -0500
Message-ID: <56548F20.7090407@hpe.com>
References: <cover.1448045168.git.linda.knippers@hpe.com>	 <e65332cc9dbb7eff02f739aa5ba357d4097b4e6a.1448045168.git.linda.knippers@hpe.com> <1448320884.27481.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4623.austin.hp.com ([15.73.212.78]:58425 "EHLO
	g2t4623.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbbKXQYD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Nov 2015 11:24:03 -0500
In-Reply-To: <1448320884.27481.2.camel@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>, "jmoyer@redhat.com" <jmoyer@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "elliott@hpe.com" <elliott@hpe.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On 11/23/2015 6:21 PM, Verma, Vishal L wrote:
> On Fri, 2015-11-20 at 19:05 -0500, Linda Knippers wrote:
>> The size of NFIT tables don't necessarily match the size of the
>> data structures that we use for them.  For example, the NVDIMM
>> Control Region Structure table is shorter for a device with
>> no block control windows than for a device with block control windows.
>> Other tables, such as Flush Hint Address Structure and the Interleave
>> Structure are variable length by definition.
>>
>> Account for the size difference when comparing table entries by
>> using the actual table size from the table header if it's less
>> than the structure size.
>>
>
> Agreed about the variable length tables - Flush Hint and Interleave. But
> for the others, this makes it possible for a buggy bios implementation
> to have a *really* small table - one that doesn't even have enough
> fields to work - to pass the add_tables stage where it might have failed
> previously.
>
> I feel there may be need for an ACPI clarification for this specifying
> whether if certain fields are irrelevant, they can be excluded entirely.
>
> For example, the DCR wording is:
> Number of Block Control Windows must match the
> corresponding number of Block Data Windows. Fields that
> follow this field are valid only if the number of Block Control
> Windows is non-zero.
>
> This leads me to believe that those fields should be 'present' but
> ignored in the case of zero block windows.

Actually, the spec is pretty clear in this case.  If you look at the
length definition for that table (5-133) it says:

	Length in bytes for entire structure.
	The length of this structure is either 32 bytes or 80 bytes. The
	length of the structure can be 32 bytes only if the Number of
	Block Control Windows field has a value of 0.

The structure is 80 bytes but it is legal to have a 32-byte table.
We hit a similar problem with the original NFIT code.  We could
explicitly check for a size of 32 but we didn't before.

> If we make add_tables process only header.length and accept the
> shortened table, there is nothing to tell future code that the structure
> that piece of memory is casted to is a truncated one.
>
> Thoughts?

If we want to be more paranoid about buggy FW when we're comparing old
and new tables, we could compare based on the length of the old and new
tables since we have both pieces of information.  That would let you catch
the case where a table size changes during a hotplug event or whenever the
_FIT is processed.  Since you were comparing based on structure size instead
of header length, I didn't change that.

-- ljk
>
> 	-Vishal
>

