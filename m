From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [RFC] ARM: imx: Add imx6q thermal
Date: Thu, 12 Jan 2012 08:15:09 +0100
Message-ID: <4F0E887D.2090009@de.bosch.com>
References: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Lee <rob.lee@linaro.org>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "patches@linaro.org" <patches@linaro.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Eric Miao <eric.miao@linaro.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rob,

On 11.01.2012 08:18, Robert Lee wrote:
> Add thermal support for i.MX6Q.  Uses recently submitted common
> cpu_cooling functionality shown here:
> 
> http://www.spinics.net/lists/linux-pm/msg26500.html
> 
> Have some todo items but basic implementation is done and I'd like to
> get any helpful feedback on it.
> 
> Todo:
> - Add sensor calibration.
> - Re-organize code/files if deemed necessary by community.

Just fyi, I had a short discussion with Eric Miao about this. The 
conclusion was:

The patch itself is OK. It's just lacking some features, but these can 
be added later. The driver supports thermal reading only, but not 
accurate as the thermal calibration data is burned into the FUSE, and 
differ from chip to chip. At the moment only incorrect thermal 
information will be exposed to user space. The patch is lacking 
connections to cpufreq and cpu hotplug, but those could be added later, too.

Best regards

Dirk
