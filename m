From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] Add support of NVDIMM memory error notification in ACPI 6.2
Date: Wed, 7 Jun 2017 14:06:31 -0700
Message-ID: <CAPcyv4hwhRc6+JW8m3zVn_tKz__wE9BHOfpjy69RS6OwiqV-PA@mail.gmail.com>
References: <20170607184947.18733-1-toshi.kani@hpe.com> <CAPcyv4i7bLU17QEmdUBQrtWP3AZxPRyKK0NN105XrTj8K3nAAQ@mail.gmail.com>
 <1496869051.9288.1.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496869051.9288.1.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Verma, Vishal L" <vishal.l.verma@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 7, 2017 at 1:57 PM, Kani, Toshimitsu <toshi.kani@hpe.com> wrote:
> On Wed, 2017-06-07 at 12:09 -0700, Dan Williams wrote:
>> On Wed, Jun 7, 2017 at 11:49 AM, Toshi Kani <toshi.kani@hpe.com>
>> wrote:
>  :
>> > +
>> > +static void acpi_nfit_uc_error_notify(struct device *dev,
>> > acpi_handle handle)
>> > +{
>> > +       struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
>> > +
>> > +       acpi_nfit_ars_rescan(acpi_desc);
>>
>> I wonder if we should gate re-scanning with a similar:
>>
>>     if (acpi_desc->scrub_mode == HW_ERROR_SCRUB_ON)
>>
>> ...check that we do in the mce notification case? Maybe not since we
>> don't get an indication of where the error is without a rescan.
>
> I think this mce case is different since the MCE handler already knows
> where the new poison location is and can update badblocks information
> for it.  Starting ARS is an optional precaution.
>
>> However, at a minimum I think we need support for the new Start ARS
>> flag ("If set to 1 the firmware shall return data from a previous
>> scrub, if any, without starting a new scrub") and use that for this
>> case.
>
> That's an interesting idea.  But I wonder how users know if it is OK to
> set this flag as it relies on BIOS implementation that is not described
> in ACPI...

Ugh, you're right. We might need a revision-id=2 version of Start ARS
so software knows that the BIOS is aware of the new flag.
