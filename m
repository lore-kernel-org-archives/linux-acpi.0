From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 2/2] net: qcom/emac: add phy-handle support for ACPI
Date: Fri, 26 Oct 2018 15:13:01 +0200
Message-ID: <20181026131301.GC30093@lunn.ch>
References: <78719753-77bd-596a-dfc7-ccd676850283@kernel.org>
 <cover.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <7935985e49270ad2948b2a52d26510bdf55572e6.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <20181025192430.GA16785@lunn.ch>
 <0a55d42c839140dd9a5264ab4dae4c8e@HXTBJIDCEMVIW02.hxtcorp.net>
 <ea868a30-13a1-f695-4e34-d873d975ebc9@kernel.org>
 <a1adfc5a696d40388ad9bf982f0ff64d@HXTBJIDCEMVIW02.hxtcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a1adfc5a696d40388ad9bf982f0ff64d@HXTBJIDCEMVIW02.hxtcorp.net>
Sender: netdev-owner@vger.kernel.org
To: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Cc: Timur Tabi <timur@kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 26, 2018 at 03:04:25AM +0000, Wang, Dongsheng wrote:
> On 2018/10/26 10:37, Timur Tabi wrote:
> > On 10/25/18 9:18 PM, Wang, Dongsheng wrote:
> >> But when I was reading Documentation/acpi/DSD-properties-rules.txt, my
> >> understanding is we should try to conform to DT bindings. So maybe ACPI
> >> doesn't have such a document, just DT bindings.
> > There was an attempt to document DSDs, but it was abandoned after a while.
> >
> > https://github.com/ahs3/dsd
> >
> 
> Yes, here's a database concept, and I asked some Intel guys, the answer
> I got was there is no such database or document. :(

Hi Dongsheng

If there is no clear documentation for ACPI, it becomes even more
important that the xgene code is refactored into a central location,
and you make use of it. We really need to avoid every ACPI ethernet
driver doing its own thing.

       Thanks
	Andrew
