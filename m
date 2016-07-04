From: Johannes Thumshirn <jthumshirn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] nfit: use devm_add_action_or_reset()
Date: Mon, 4 Jul 2016 09:31:22 +0200
Message-ID: <20160704073122.nkvnnminfrnuhhb4@c203.arch.suse.de>
References: <1467606771-21704-1-git-send-email-vikas.cha.sajjan@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467606771-21704-1-git-send-email-vikas.cha.sajjan-ZPxbGqLxI0U@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Vikas C Sajjan <vikas.cha.sajjan-ZPxbGqLxI0U@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 04, 2016 at 10:02:51AM +0530, Vikas C Sajjan wrote:
> If devm_add_action() fails, we are explicitly calling the cleanup to free
> the resources allocated. Lets use the helper devm_add_action_or_reset()
> and return directly in case of error, since the cleanup function
> has been already called by the helper if there was any error.
> =

> Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan-ZPxbGqLxI0U@public.gmane.org>

Reviewed-by: Johannes Thumshirn <jthumshirn-l3A5Bk7waGM@public.gmane.org>

-- =

Johannes Thumshirn                                          Storage
jthumshirn-l3A5Bk7waGM@public.gmane.org                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
