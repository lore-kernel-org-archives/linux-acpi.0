From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
Date: Wed, 29 Jun 2016 23:14:29 +0200
Message-ID: <CAJZ5v0h1o5C8t+QJuFo93uZt0XuPNwtXFs5XSBkhm-fARWqi2g@mail.gmail.com>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0j+CJ3qWTdvm6Sk3DqFYVnkuEmaR1EPZM6DDVMC8rsK+g@mail.gmail.com>
 <d22fd8f7-7028-b4b7-6677-6903685034aa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d22fd8f7-7028-b4b7-6677-6903685034aa@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Andy Gross <agross@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, tiwai@suse.com, perex@perex.cz, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Christopher Covington <cov@codeaurora.org>, eric.auger@redhat.com, Linux PCI <linux-pci@vger.kernel.org>, wim@djo.tudelft.nl, linux-arm-msm@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 29, 2016 at 8:29 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/29/2016 9:16 AM, Rafael J. Wysocki wrote:
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Well, this is a rather obvious one, so I'm wondering why it is the
>> last one in the series?
>>
>
> The first three are more relevant to each other. It makes easy to
> correlate the changes.

But this one doesn't seem to depend on them and it could be applied
without them, right?

Thanks,
Rafael
