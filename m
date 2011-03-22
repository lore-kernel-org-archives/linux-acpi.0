From: Cong Wang <amwang@redhat.com>
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Tue, 22 Mar 2011 14:31:44 +0800
Message-ID: <4D884250.3040302@redhat.com>
References: <1299766243-494-1-git-send-email-amwang@redhat.com> <20110310143923.GB29464@redhat.com> <m1oc5ig90b.fsf@fess.ebiederm.org> <20110310185019.GB23105@srcf.ucam.org> <4D86F2C2.9080707@redhat.com> <m1hbawkifj.fsf@fess.ebiederm.org> <20110321155629.GF2694@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20110321155629.GF2694@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Matthew Garrett <mjg@redhat.com>, linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, Randy Dunlap <rdunlap@xenotime.net>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-acpi@vger.kernel.org

=E4=BA=8E 2011=E5=B9=B403=E6=9C=8821=E6=97=A5 23:56, Vivek Goyal =E5=86=
=99=E9=81=93:
>
> Matthew and I were chatting in general about it couple of days back a=
nd
> mattew suggested how about if we embrace the idea of booting the kern=
el
> always in physical mode (both first and second) and keep that extra s=
et
> of pagetables around to make EFI calls. That way kexec/kdump should j=
ust
> work and kernel changes also might not be too much.
>
> The potential problem with this is that this might expose various kin=
d
> of BIOS issues with different vendors as vendors might not test the
> physical path.

=46irst I have to say I know a little about EFI.

I am wondering what benefits we will lose if we use physical mode?
comparing it with virtual mode? If very few, this could be a solution.

Thanks.
