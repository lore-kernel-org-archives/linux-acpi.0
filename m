From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose
 embedded WMI MOF metadata
Date: Tue, 6 Jun 2017 15:56:21 +0200
Message-ID: <20170606135621.GC4690@pali>
References: <cover.1495862272.git.dvhart@infradead.org>
 <201705271314.16241@pali>
 <20170605221456.GA27270@fury>
 <201706060019.26462@pali>
 <CALCETrXTejMgbQZaHOKuEM_rF4bMduEzwWZ6+7R2M+gbFo5LMg@mail.gmail.com>
 <20170606110554.GB4690@pali>
 <8aa135f430b441eb82614b22d662d1ff@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8aa135f430b441eb82614b22d662d1ff@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: luto@amacapital.net, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, andriy.shevchenko@linux.intel.com, luto@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 06 June 2017 13:46:16 Mario.Limonciello@dell.com wrote:
> Pali,
> 
> Amazing job with what you've done so far.  A few comments I wanted to share from my taking look at your bmf2mof and comparing to "source" MOF.
> 1) At least in source the case used for String and Boolean is lower case.  I'm unsure if that actually matters for any MOF parsing tools, but I wanted to FYI in case it does.

In MS documentation is String, Boolean and Datetime with first char
uppercase. But looks like mofcomp accept both upper case and lower case
variants.

> 2) On my system when you expand the arguments for "void DoBFn" the source doesn't describe individual arguments like you do.  
> Again this might not matter to MOF parsing tools but wanted to let you know in case it does.

I know, this part is missing. Order of arguments are only in ID
qualifier and not sorted + in/out de-duplicated.

> source:
> 	void DoBFn([in, out, Description("Fn buf")] BDat Data);
> bmf2mof:
> 	void doBFn([in, Description("Fn buf"), ID(0)] BDat Data, [out, Description("Fn buf"), ID(0)] BDat Data);

-- 
Pali Rohár
pali.rohar@gmail.com
