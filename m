From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date: Tue, 11 Dec 2018 18:00:19 -0500
Message-ID: <edc8afd7-64a0-a143-e8d6-df3b14b21753@kernel.org>
References: <20181210181315.5023-1-okaya@kernel.org>
 <20181210181315.5023-2-okaya@kernel.org> <20181211170957.GA335@infradead.org>
 <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
 <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com>
 <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
 <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
 <6644defb-9199-6467-6e3e-8ce552b56f87@kernel.org>
 <CAJZ5v0i+rgLL+KrRs69URbGhUxDK9eUEuLifDWuL2mgpkAv_1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i+rgLL+KrRs69URbGhUxDK9eUEuLifDWuL2mgpkAv_1g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/11/2018 5:51 PM, Rafael J. Wysocki wrote:
> Well, users running kernels with CONFIG_PCI unset on platforms
> expecting PCI support to be present in the OS may want to know that I
> suppose, so that would be a good reason to return an error, but
> perhaps just once rather than on every access (maybe unless debugging
> is enabled?).

Warning once would be a good trade-off.
