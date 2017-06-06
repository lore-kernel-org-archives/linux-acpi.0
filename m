From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose
 embedded WMI MOF metadata
Date: Tue, 6 Jun 2017 13:05:54 +0200
Message-ID: <20170606110554.GB4690@pali>
References: <cover.1495862272.git.dvhart@infradead.org>
 <201705271314.16241@pali>
 <20170605221456.GA27270@fury>
 <201706060019.26462@pali>
 <CALCETrXTejMgbQZaHOKuEM_rF4bMduEzwWZ6+7R2M+gbFo5LMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXTejMgbQZaHOKuEM_rF4bMduEzwWZ6+7R2M+gbFo5LMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 05 June 2017 15:39:44 Andy Lutomirski wrote:
> On Mon, Jun 5, 2017 at 3:19 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Tuesday 06 June 2017 00:14:56 Darren Hart wrote:
> >> On Sat, May 27, 2017 at 01:14:15PM +0200, Pali Rohár wrote:
> >> > > metadata. I think that Samba has tools to interpret it, but there
> >> > > is currently no interface to get the data in the first place.
> >> >
> >> > No, there is no non-ms-windows tool for interpreting those binary
> >> > MOF (BMF) data yet.
> >>
> >> Good point. Updated.
> >
> > You are too late :-) Now there is my at https://github.com/pali/bmfdec
> > See my email "Binary MOF buffer in WMI is finally decoded!".
> >
> 
> It comes out like this on my laptop.  I don't know enough about MOF to
> know what we're supposed to do with this, but I suspect it at least
> gives us the sizes of buffers that we should be passing to the various
> methods.

There are two tools bmfparse and bmf2mof. Difference is just output
format.

Important are WmiDataId and WmiMethodId qualifiers. Those define ids are
what are passed to kernel function wmi_evaluate_method(). Ids are
processed by corresponding WMxx ACPI function.

So instead of

  wmi_evaluate_method(guid, instance, method_id, acpi_in, acpi_out);

it should be possible to call:

  wmi_evaluate_method_name(class, name, input_params, output_params);

(once somebody implement wmi_evaluate_method_name function)

It is more readable in code to use class and function names instead of
some guids and random meaningless numbers. Also it would allow to check
size of input buffer (or types).

E.g.

  BDat data_in;
  BDat data_out;
  // fill data_in.Bytes
  wmi_evaluate_method_name("BFn", "DoBFn", &data_in, &data_out);
  // output is in data_out.Bytes

could be translated to:

  wmi_evaluate_method("A80593CE-A997-11DA-B012-B622A1EF5492", 0, 1, acpi_in, acpi_out);

Sometimes method_id is random number and hard to guess it. One of
possible solution is to trace ACPI calls on Windows, another is decode
that BMOF buffer and take correct method_id.

I will probably write another one tool which prints just important WMI
functions and their mapping to WMI ids + input/output parameters.
Without all other MOF data which are not relevant to ACPI-WMI.

> class WMIEvent : __ExtrinsicEvent {
> };
> 
> [WMI, Locale("MS\0x409"), Description("QDATA"),
> guid("{ABBC0F60-8EA1-11d1-00A0-C90629100000}")]
> class QDat {
>   [WmiDataId(1), read, write, Description("qdata")] uint8 Bytes[128];
> };
> 
> [WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
> Description("BIOS WMI Query"),
> guid("{8D9DDCBC-A997-11DA-B012-B622A1EF5492}")]
> class WMI_Query {
>   [key, read] String InstanceName;
>   [read] Boolean Active;
>   [WmiDataId(1), read, write, Description("BIOS WMI info")] QDat QDATA;
> };
> 
> [WMI, Locale("MS\0x409"), Description("Data"),
> guid("{a3776ce0-1e88-11db-a98b-0800200c9a66}")]
> class BDat {
>   [WmiDataId(1), read, write, Description("data")] uint8 Bytes[4096];
> };
> 
> [WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
> Description("Interface"),
> guid("{A80593CE-A997-11DA-B012-B622A1EF5492}")]
> class BFn {
>   [key, read] String InstanceName;
>   [read] Boolean Active;
> 
>   [WmiMethodId(1), Implemented, read, write, Description("Do BFn")]
> void DoBFn([in, Description("Fn buf"), ID(0)] BDat Data, [out,
> Description("Fn buf"), ID(0)] BDat Data);
> };
> 
> [WMI, Dynamic, Provider("WmiProv"), Locale("MS\0x409"),
> Description("Event"), guid("{9DBB5994-A997-11DA-B012-B622A1EF5492}")]
> class BIOSEvent : WmiEvent {
>   [key, read] String InstanceName;
>   [read] Boolean Active;
>   [WmiDataId(1), read, write, Description("Ev buf")] QDat Data;
> };

-- 
Pali Rohár
pali.rohar@gmail.com
