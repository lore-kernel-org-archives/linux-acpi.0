From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Sat, 7 Mar 2009 20:26:47 +0000
Message-ID: <20090307202647.GA9776@srcf.ucam.org>
References: <20090306003941.GA32403@srcf.ucam.org>
	<E1LfqwF-000B1G-00.arvidjaar-mail-ru@mx3.mail.ru>
	<20090307150640.GA3516@srcf.ucam.org>
	<200903071839.16508.arvidjaar@mail.ru>
	<20090307154424.GA3909@srcf.ucam.org>
	<15e53e180903071219q4ed318edt2fa8f492426c0ab6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <hal-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <15e53e180903071219q4ed318edt2fa8f492426c0ab6@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: Richard Hughes <hughsient@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hal@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 07, 2009 at 08:19:51PM +0000, Richard Hughes wrote:

> Mapping KEY_SUSPEND to hibernate is just insane. Can you please change
> the toshiba driver to use KEY_HIBERNATE and KEY_SUSPEND as thinkpad
> now does? Thanks.

Mapping KEY_SUSPEND to hibernate is what we've been doing for years. 
It's what hal *still does*. KEY_SLEEP has been the suspend to RAM key 
forever. How are we supposed to perform this transition? We've no idea 
how much of userspace makes the same assumption.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
