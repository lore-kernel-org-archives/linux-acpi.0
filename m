From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH 1/2] PCI/ACPI: correct error message for ASPM disabling
Date: Thu, 9 Aug 2018 22:15:09 -0400
Message-ID: <2a8b5c60-45ba-1fc4-d261-fcfbd7f16910@kernel.org>
References: <1533840383-7841-1-git-send-email-okaya@kernel.org>
 <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 8/9/2018 8:27 PM, Joe Perches wrote:
> I think this would read better not using a temporary and
> using a ternary instead.

Makes sense.
