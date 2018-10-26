From: Timur Tabi <timur@kernel.org>
Subject: Re: [PATCH v3 2/2] net: qcom/emac: add phy-handle support for ACPI
Date: Thu, 25 Oct 2018 21:37:37 -0500
Message-ID: <ea868a30-13a1-f695-4e34-d873d975ebc9@kernel.org>
References: <78719753-77bd-596a-dfc7-ccd676850283@kernel.org>
 <cover.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <7935985e49270ad2948b2a52d26510bdf55572e6.1540459999.git.dongsheng.wang@hxt-semitech.com>
 <20181025192430.GA16785@lunn.ch>
 <0a55d42c839140dd9a5264ab4dae4c8e@HXTBJIDCEMVIW02.hxtcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0a55d42c839140dd9a5264ab4dae4c8e@HXTBJIDCEMVIW02.hxtcorp.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "robert.moore@intel.com" <robert.moore@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 10/25/18 9:18 PM, Wang, Dongsheng wrote:
> But when I was reading Documentation/acpi/DSD-properties-rules.txt, my
> understanding is we should try to conform to DT bindings. So maybe ACPI
> doesn't have such a document, just DT bindings.

There was an attempt to document DSDs, but it was abandoned after a while.

https://github.com/ahs3/dsd
