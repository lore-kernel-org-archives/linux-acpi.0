From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH][next] gpiolib-acpi: remove unused variable 'err', cleans
 up build warning
Date: Tue, 18 Dec 2018 14:44:31 +0200
Message-ID: <20181218124431.GK2469@lahna.fi.intel.com>
References: <20181218122802.28157-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218122802.28157-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 18, 2018 at 12:28:02PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable err is defined but never used. Remove it. Cleans up warning:
> 
> warning: unused variable ‘err’ [-Wunused-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
