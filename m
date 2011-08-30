From: Huang Ying <ying.huang@intel.com>
Subject: Re: APEI: Can not request iomem region for GARs
Date: Tue, 30 Aug 2011 08:55:14 +0800
Message-ID: <4E5C34F2.3030507@intel.com>
References: <CAG1a4rs4Cr1z50gGuK9SLE6aOvibE1sdV_GSLPv+gqYC8g+ORQ@mail.gmail.com> <CAErSpo4FfBoGDUquoLNsJ9=z-M-x6NQgP8xJL_VqEXpsL2H5PA@mail.gmail.com> <4E520149.3010802@intel.com> <CAG1a4rtMnDXSGLkmwE+6N9smoghWp0W4b5-X_gogzJ9fDLTeBg@mail.gmail.com> <4E571D66.1070302@intel.com> <CAG1a4rtckCtpNjg9ApiLt4zQWArAu7N2ivoiMjueqYDRrr-G+g@mail.gmail.com> <4E5AE82E.6000807@intel.com> <CAG1a4rsyQ5Ox_5i7K9tZT5q3YAnwRiG4uPkAkyY8JUZUjDkHpQ@mail.gmail.com> <4E5B221B.4080309@intel.com> <CAG1a4rv2EhRE6O_0MT5NMN1T=087AZs3kBgv3iBTMsMbOpU+vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG1a4rv2EhRE6O_0MT5NMN1T=087AZs3kBgv3iBTMsMbOpU+vQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Ivanov <paivanof@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 08/29/2011 10:43 PM, Pavel Ivanov wrote:
> On Mon, Aug 29, 2011 at 1:22 AM, Huang Ying <ying.huang@intel.com> wrote:
>> -ENOENT is returned for apei_exec_run(, ACPI_ERST_GET_ERROR_RANGE).
>> That is there is no instructions for mandatory action
>> ACPI_ERST_GET_ERROR_RANGE.  It should be a firmware bug, try raise it to
>> firmware vendor?
> 
> Could you please advise me on how should I do that? Do I need to
> report this issue to my motherboard vendor (which is Asus)? If yes
> then should it be via the standard technical support channel (like
> http://vip.asus.com/eservice/techserv.aspx) or something more special?

Sorry, I don't know how to do that too.

Best Regards,
Huang Ying
