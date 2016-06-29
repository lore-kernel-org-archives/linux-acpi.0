From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
Date: Wed, 29 Jun 2016 23:40:35 +0200
Message-ID: <CAJZ5v0i67f+zsg_Ui693C3szFskOE3vQ1JsKYZpUkvc=vzXqcQ@mail.gmail.com>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-5-git-send-email-okaya@codeaurora.org> <CAJZ5v0j+CJ3qWTdvm6Sk3DqFYVnkuEmaR1EPZM6DDVMC8rsK+g@mail.gmail.com>
 <d22fd8f7-7028-b4b7-6677-6903685034aa@codeaurora.org> <CAJZ5v0h1o5C8t+QJuFo93uZt0XuPNwtXFs5XSBkhm-fARWqi2g@mail.gmail.com>
 <96388f6b-f8b1-5720-4725-3f0ec0f5d1c3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <96388f6b-f8b1-5720-4725-3f0ec0f5d1c3@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Jon Masters <jcm@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, wim@djo.tudelft.nl, perex@perex.cz, tiwai@suse.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2016 at 11:19 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/29/2016 5:14 PM, Rafael J. Wysocki wrote:
>> On Wed, Jun 29, 2016 at 8:29 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> On 6/29/2016 9:16 AM, Rafael J. Wysocki wrote:
>>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> Well, this is a rather obvious one, so I'm wondering why it is the
>>>> last one in the series?
>>>>
>>>
>>> The first three are more relevant to each other. It makes easy to
>>> correlate the changes.
>>
>> But this one doesn't seem to depend on them and it could be applied
>> without them, right?
>>
>
> Sure. It has no dependency.

OK

I've queued up this one.

Thanks,
Rafael
