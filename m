From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 06/11] platform/x86: apple-gmux: Make PCI dependency
 explicit
Date: Sun, 30 Dec 2018 21:01:50 +0100
Message-ID: <20181230200150.pyxg5bv7qcpj7de2@wunner.de>
References: <20181230195612.6657-1-okaya@kernel.org>
 <20181230195612.6657-7-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181230195612.6657-7-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 30, 2018 at 07:56:07PM +0000, Sinan Kaya wrote:
> This driver depends on the PCI infrastructure but the dependency has not
> been explicitly called out.
> 
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
