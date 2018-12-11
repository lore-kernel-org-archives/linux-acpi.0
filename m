From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date: Tue, 11 Dec 2018 11:52:25 -0500
Message-ID: <50b7ee57-d066-fdd8-e497-259b695aab52@kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org>
 <CAJZ5v0htmHTgRa9TZ7f0XcGEt_XMmfEYhcQ=N2Lcn1V+TxPzxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0htmHTgRa9TZ7f0XcGEt_XMmfEYhcQ=N2Lcn1V+TxPzxg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/11/2018 5:07 AM, Rafael J. Wysocki wrote:
> On Mon, Dec 10, 2018 at 7:13 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
>> out calls that depend on PCI.
> 
> I would prefer the subject to say something like "Allow CONFIG_PCI to
> be unset" or "Allow PCI to be disabled in Kconfig".
> 
> It is somewhat ambiguous otherwise and one has to look at the patch to
> see what it really is about.
> 

Makes sense. I'll update.
